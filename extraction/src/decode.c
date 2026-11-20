/* Decode designated code ranges with pinned Intel XED and print each
 * instruction for stack analysis. */
#include <errno.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "xed/xed-interface.h"

static uint64_t number(const char *text) {
    char *end;
    errno = 0;
    uint64_t value = strtoull(text, &end, 0);
    if (errno || *text == '-' || !*text || *end) {
        fprintf(stderr, "Invalid unsigned number: %s\n", text);
        exit(2);
    }
    return value;
}

/* Fields: address, next, class, category, width, registers,
 * memory address, immediate, branch displacement, and whether RSP is written. */
static void analysis(FILE *out, const xed_decoded_inst_t *d, uint64_t address) {
    int writes_rsp = 0, writes_dst = 0, explicit_memory = 0;
    for (unsigned i = 0; i < xed_inst_noperands(xed_decoded_inst_inst(d)); ++i) {
        const xed_operand_t *op = xed_inst_operand(xed_decoded_inst_inst(d), i);
        xed_operand_enum_t name = xed_operand_name(op);
        if (name == XED_OPERAND_REG0 && xed_operand_written(op)) writes_dst = 1;
        if ((name == XED_OPERAND_MEM0 || name == XED_OPERAND_AGEN) &&
            xed_operand_operand_visibility(op) == XED_OPVIS_EXPLICIT) explicit_memory = 1;
        if (xed_operand_is_register(name) && xed_operand_written(op) &&
            xed_get_largest_enclosing_register(xed_decoded_inst_get_reg(d, name)) == XED_REG_RSP)
            writes_rsp = 1;
    }
    fprintf(out, "%" PRIu64 " %" PRIu64 " %s %s %u %s %s %s %s %" PRId64 " %u %" PRId64 " %u %" PRId64 " %d %d\n",
            address, address + xed_decoded_inst_get_length(d),
            xed_iclass_enum_t2str(xed_decoded_inst_get_iclass(d)),
            xed_category_enum_t2str(xed_decoded_inst_get_category(d)),
            xed_decoded_inst_get_operand_width(d),
            xed_reg_enum_t2str(xed_get_largest_enclosing_register(xed_decoded_inst_get_reg(d, XED_OPERAND_REG0))),
            xed_reg_enum_t2str(xed_get_largest_enclosing_register(xed_decoded_inst_get_reg(d, XED_OPERAND_REG1))),
            explicit_memory ? xed_reg_enum_t2str(xed_decoded_inst_get_base_reg(d, 0)) : "INVALID",
            explicit_memory ? xed_reg_enum_t2str(xed_decoded_inst_get_index_reg(d, 0)) : "INVALID",
            (int64_t)xed_decoded_inst_get_memory_displacement(d, 0),
            xed_decoded_inst_get_immediate_width_bits(d),
            xed_decoded_inst_get_immediate_is_signed(d)
                ? (int64_t)xed_decoded_inst_get_signed_immediate(d)
                : (int64_t)xed_decoded_inst_get_unsigned_immediate(d),
            xed_decoded_inst_get_branch_displacement_width(d),
            (int64_t)xed_decoded_inst_get_branch_displacement(d), writes_rsp, writes_dst);
}

int main(int argc, char **argv) {
    if (argc < 4) return 2;
    uint64_t address = number(argv[2]), size = number(argv[3]);
    if (!size || size > SIZE_MAX || size - 1 > UINT64_MAX - address) return 2;
    FILE *file = fopen(argv[1], "rb");
    if (!file) { perror(argv[1]); return 2; }
    unsigned char *bytes = malloc((size_t)size);
    if (!bytes || fread(bytes, 1, (size_t)size, file) != size) {
        fprintf(stderr, "Cannot read the complete requested range\n"); return 2;
    }
    fclose(file);
    xed_tables_init();
    xed_chip_features_t features = {{0}};
    /* Long-mode baseline plus TSC and PREFETCH_NOP for selected PREFETCHW forms.
     * Optional overlapping encodings are explicit below. */
    char baseline[] = "I86 I186 I286REAL I286PROTECTED I386 I486REAL PENTIUMREAL PPRO LONGMODE X87 CMOV FCMOV FCOMI PENTIUMMMX FXSAVE FXSAVE64 SSE SSE2 SSE2MMX SSEMXCSR SSE_PREFETCH PREFETCH_NOP PAUSE FAT_NOP PPRO_UD0_LONG";
    for (char *f = strtok(baseline, " "); f; f = strtok(NULL, " "))
        xed_modify_chip_features(&features, str2xed_isa_set_enum_t(f), 1);
    for (int i = 4; i < argc; ++i) {
        const char *feature;
        if (!strcmp(argv[i], "lzcnt")) feature = "LZCNT";
        else if (!strcmp(argv[i], "cet")) feature = "CET";
        else if (!strcmp(argv[i], "cmpxchg16b")) feature = "CMPXCHG16B";
        else { fprintf(stderr, "Unknown feature: %s\n", argv[i]); return 2; }
        xed_isa_set_enum_t set = str2xed_isa_set_enum_t(feature);
        if (set == XED_ISA_SET_INVALID) return 2;
        xed_modify_chip_features(&features, set, 1);
    }
    xed_state_t mode;
    xed_state_init2(&mode, XED_MACHINE_MODE_LONG_64, XED_ADDRESS_WIDTH_64b);
    for (size_t position = 0; position < size;) {
        xed_decoded_inst_t d;
        xed_decoded_inst_zero_set_mode(&d, &mode);
        xed_decoded_inst_set_input_chip(&d, XED_CHIP_PENTIUM4);
        unsigned remaining = size - position > 15 ? 15 : (unsigned)(size - position);
        xed_error_enum_t error = xed_decode_with_features(&d, bytes + position, remaining, &features);
        if (error != XED_ERROR_NONE) {
            fprintf(stderr, "Address 0x%" PRIx64 ": %s\n", address + position, xed_error_enum_t2str(error));
            return 1;
        }
        unsigned length = xed_decoded_inst_get_length(&d);
        if (!length || length > remaining) return 1;
        analysis(stdout, &d, address + position);
        position += length;
    }
    free(bytes);
    return ferror(stdout) ? 2 : 0;
}
