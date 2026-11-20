//! Candidate System V stack budgets, not proofs. Like MLKEM's original exporter,
//! this recognizes compiler patterns and approximates indirect calls using loaded
//! function addresses and the function pointers the image holds at startup. Consumers must
//! prove the chosen budget.
use crate::elf::Image;
use anyhow::{ensure, Result};
use std::collections::{BTreeMap, BTreeSet};

type Analysis<T> = std::result::Result<T, String>;

fn add(a: u64, b: u64) -> Analysis<u64> {
    a.checked_add(b).ok_or_else(|| "stack size overflow".into())
}

struct Instruction<'a> {
    address: u64,
    next: u64,
    class: &'a str,
    category: &'a str,
    width: u64,
    dst: &'a str,
    src: &'a str,
    base: &'a str,
    index: &'a str,
    displacement: i64,
    immediate: Option<i64>,
    target: Option<u64>,
    writes_rsp: bool,
    writes_dst: bool,
}

impl<'a> Instruction<'a> {
    fn parse(line: &'a str) -> Result<Self> {
        // Field order is shared with analysis() in decode.c.
        let f: Vec<_> = line.split_whitespace().collect();
        ensure!(f.len() == 16, "invalid decoder stack metadata");
        let next: u64 = f[1].parse()?;
        Ok(Self {
            address: f[0].parse()?,
            next,
            class: f[2],
            category: f[3],
            width: f[4].parse()?,
            dst: f[5],
            src: f[6],
            base: f[7],
            index: f[8],
            displacement: f[9].parse()?,
            immediate: (f[10] != "0").then_some(f[11].parse()?),
            target: (f[12] != "0").then_some(next.wrapping_add_signed(f[13].parse()?)),
            writes_rsp: f[14] == "1",
            writes_dst: f[15] == "1",
        })
    }

    fn allocation(&self) -> Analysis<u64> {
        let adjusts_rsp = self.dst == "RSP" && self.width == 64;
        let amount = self.immediate.and_then(|n| u64::try_from(n).ok());
        match self.class {
            "PUSH" | "PUSHFQ" | "PUSHFW" => Ok(self.width / 8),
            "SUB" if adjusts_rsp => {
                amount.ok_or_else(|| format!("dynamic stack adjustment at {:#x}", self.address))
            }
            "ADD" if adjusts_rsp && amount.is_some() => Ok(0),
            "POP" if self.dst != "RSP" => Ok(0),
            "POPFQ" | "POPFW" | "CALL_NEAR" | "RET_NEAR" => Ok(0),
            _ if !self.writes_rsp => Ok(0),
            _ => Err(format!(
                "unsupported stack adjustment at {:#x}",
                self.address
            )),
        }
    }

    fn rip_address(&self) -> Option<u64> {
        (self.base == "RIP" && self.index == "INVALID")
            .then(|| self.next.wrapping_add_signed(self.displacement))
    }
}

struct Function {
    frame: u64,
    red_zone: u64,
    calls: BTreeMap<u64, u64>, // target -> return-address bytes (zero for tail calls)
    /// Return-address bytes of the calls that may target any indirect target, if any
    indirect_return_bytes: Option<u64>,
}

/// The candidate targets of a call through memory, shared by every such call: one edge to them
/// all, whose depth is computed once, instead of an edge to each from each call
struct IndirectTargets {
    addresses: BTreeSet<u64>,
    /// Whether every target is a panic function, so that a call does not return
    all_panics: bool,
}

/// A node of the call graph: a function, or the targets of every call through memory
#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
enum Node {
    Function(u64),
    IndirectTargets,
}

fn function(
    image: &Image,
    code: &[Instruction<'_>],
    indirect_targets: &IndirectTargets,
) -> Analysis<Function> {
    let start = code.first().ok_or("missing function instructions")?.address;
    let end = code.last().unwrap().next;
    let mut result = Function {
        frame: 0,
        red_zone: 128,
        calls: BTreeMap::new(),
        indirect_return_bytes: None,
    };
    let mut allocations = BTreeSet::new();
    let mut loaded: BTreeMap<&str, BTreeSet<u64>> = BTreeMap::new();
    let mut copies = Vec::new();
    for i in code {
        let amount = i.allocation()?;
        result.frame = add(result.frame, amount)?;
        if amount != 0 {
            allocations.insert(i.address);
        }
        if i.base == "RSP" && i.index == "INVALID" && i.displacement < 0 {
            result.red_zone = result.red_zone.max(i.displacement.unsigned_abs());
        }
        if i.width != 64 || !i.writes_dst {
            continue;
        }
        let value = match i.class {
            "LEA" => i.rip_address(),
            "MOV" => i
                .rip_address()
                .and_then(|a| image.pointer_at(a))
                .or_else(|| {
                    i.immediate
                        .filter(|_| image.immediates_are_addresses())
                        .map(|n| n as u64)
                }),
            _ => None,
        };
        if let Some(value) = value.filter(|v| image.functions.contains(v)) {
            loaded.entry(i.dst).or_default().insert(value);
        } else if i.class == "MOV" && i.base == "INVALID" && i.src != "INVALID" {
            copies.push((i.src, i.dst));
        }
    }
    loop {
        let mut changed = false;
        for &(src, dst) in &copies {
            let values = loaded.get(src).cloned().unwrap_or_default();
            let target = loaded.entry(dst).or_default();
            let old = target.len();
            target.extend(values);
            changed |= target.len() != old;
        }
        if !changed {
            break;
        }
    }
    let mut pending = vec![start];
    let mut visited = BTreeSet::new();
    while let Some(address) = pending.pop() {
        if !visited.insert(address) {
            continue;
        }
        // A reachable symbol boundary is a tail call, without a return address.
        if address == end {
            if !image.functions.contains(&end) {
                return Err(format!("unresolved fallthrough at {end:#x}"));
            }
            result.calls.entry(end).or_insert(0);
            continue;
        }
        let index = code
            .binary_search_by_key(&address, |i| i.address)
            .map_err(|_| format!("missing instructions at {address:#x}"))?;
        let i = &code[index];
        let call = i.category == "CALL";
        if !call && !matches!(i.category, "RET" | "UNCOND_BR") {
            pending.push(i.next);
        }
        if !matches!(i.category, "CALL" | "COND_BR" | "UNCOND_BR") {
            continue;
        }
        if let Some(target) = i.target.filter(|t| !call && (start..end).contains(t)) {
            if target <= i.address && allocations.range(target..=i.address).next().is_some() {
                return Err(format!("stack allocation in a loop at {:#x}", i.address));
            }
            pending.push(target);
            continue;
        }
        let overhead = if call { 8 } else { 0 };
        if i.target.is_none() && i.rip_address().is_none() && i.base != "INVALID" {
            // Compiler-pattern heuristic: trait-object calls may target any
            // function pointer in read-only data, or any relocated slot, outside the GOT.
            if indirect_targets.addresses.is_empty() {
                return Err(format!("unresolved call or branch at {:#x}", i.address));
            }
            // Panic calls retain their stack costs but do not return.
            if call && !indirect_targets.all_panics {
                pending.push(i.next);
            }
            result.indirect_return_bytes =
                Some(result.indirect_return_bytes.unwrap_or(0).max(overhead));
            continue;
        }
        let targets = if let Some(target) = i.target {
            BTreeSet::from([target])
        } else if let Some(slot) = i.rip_address() {
            BTreeSet::from([image
                .pointer_at(slot)
                .ok_or_else(|| format!("unreadable call slot at {:#x}", i.address))?])
        } else {
            loaded.get(i.dst).cloned().unwrap_or_default()
        };
        if targets.is_empty() || !targets.is_subset(&image.functions) {
            return Err(format!("unresolved call or branch at {:#x}", i.address));
        }
        // Panic calls retain their stack costs but do not return.
        if call && !targets.is_subset(&image.panics) {
            pending.push(i.next);
        }
        for target in targets {
            result
                .calls
                .entry(target)
                .and_modify(|n| *n = (*n).max(overhead))
                .or_insert(overhead);
        }
    }
    Ok(result)
}

fn depth(
    node: Node,
    functions: &BTreeMap<u64, Analysis<Function>>,
    indirect_targets: &IndirectTargets,
    level: usize,
    cache: &mut BTreeMap<Node, Analysis<u64>>,
) -> Analysis<u64> {
    if let Some(result) = cache.get(&node) {
        return result.clone();
    }
    // Encountering this entry again before completion identifies a cycle.
    let through = match node {
        Node::Function(address) => format!("{address:#x}"),
        Node::IndirectTargets => "an indirect call".to_owned(),
    };
    cache.insert(node, Err(format!("recursive call through {through}")));
    let result = (|| {
        if level == 256 {
            return Err("call graph exceeds analysis depth limit".into());
        }
        let address = match node {
            Node::Function(address) => address,
            // The targets are one call from the caller, at this node's level.
            Node::IndirectTargets => {
                let mut deepest = 0;
                for &target in &indirect_targets.addresses {
                    let target = depth(
                        Node::Function(target),
                        functions,
                        indirect_targets,
                        level,
                        cache,
                    )?;
                    deepest = deepest.max(target);
                }
                return Ok(deepest);
            }
        };
        let f = functions
            .get(&address)
            .ok_or_else(|| format!("missing function at {address:#x}"))?
            .as_ref()
            .map_err(Clone::clone)?;
        let mut below = f.red_zone;
        let calls = f
            .calls
            .iter()
            .map(|(&target, &overhead)| (Node::Function(target), overhead));
        for (callee, overhead) in calls.chain(
            f.indirect_return_bytes
                .map(|overhead| (Node::IndirectTargets, overhead)),
        ) {
            below = below.max(add(
                depth(callee, functions, indirect_targets, level + 1, cache)?,
                overhead,
            )?);
        }
        add(f.frame, below)
    })();
    cache.insert(node, result.clone());
    result
}

pub fn estimates(image: &Image, metadata: &str) -> Result<BTreeMap<u64, Analysis<u64>>> {
    let mut instructions = metadata
        .lines()
        .map(Instruction::parse)
        .collect::<Result<Vec<_>>>()?;
    instructions.sort_by_key(|i| i.address);
    let targets: BTreeSet<_> = image
        .pointer_slots()
        .into_iter()
        .filter(|&(address, target)| {
            image.got.is_none_or(|got| address < got) && image.functions.contains(&target)
        })
        .map(|(_, target)| target)
        .collect();
    let indirect_targets = IndirectTargets {
        all_panics: targets.is_subset(&image.panics),
        addresses: targets,
    };
    let mut functions = BTreeMap::new();
    for section in image.sections.iter().filter(|s| s.code) {
        let end = section.address + section.bytes.len() as u64;
        let starts: Vec<_> = image
            .functions
            .range(section.address..end)
            .copied()
            .chain([end])
            .collect();
        for pair in starts.windows(2) {
            let first = instructions.partition_point(|i| i.address < pair[0]);
            let last = instructions.partition_point(|i| i.address < pair[1]);
            let code = &instructions[first..last];
            let estimate = if code.first().is_some_and(|i| i.address == pair[0]) {
                function(image, code, &indirect_targets)
            } else {
                Err(format!("missing instructions at {:#x}", pair[0]))
            };
            functions.insert(pair[0], estimate);
        }
    }
    let mut cache = BTreeMap::new();
    Ok(image
        .entries
        .values()
        .map(|&address| {
            (
                address,
                depth(
                    Node::Function(address),
                    &functions,
                    &indirect_targets,
                    0,
                    &mut cache,
                ),
            )
        })
        .collect())
}
