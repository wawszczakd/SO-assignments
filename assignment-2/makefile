CC = gcc
CFLAGS = -Wall -Wextra -Wno-implicit-fallthrough -std=c17 -O2

all: example

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

core.o: core.asm
	nasm -DN=2 -f elf64 -w+all -w+error -o core.o core.asm

example: core.o example.o example.c
	$(CC) -z noexecstack -o example core.o example.o -lpthread

clean:
	-rm -f *.o example

.PHONY: all clean
