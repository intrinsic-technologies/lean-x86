.PHONY: all clean
all: .cache/decode-instructions

.cache/kit/lib/libxed.a:
	python3 ../vendor/xed/mfile.py --build-dir=$(CURDIR)/.cache/build --install-dir=$(CURDIR)/.cache/kit --jobs=4 install

.cache/decode-instructions: src/decode.c .cache/kit/lib/libxed.a
	$(CC) $(CFLAGS) -std=c11 -Wall -Wextra -Werror -I.cache/kit/include $< .cache/kit/lib/libxed.a -o $@

clean:
	rm -rf .cache
