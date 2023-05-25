CC = gcc
CFLAGS = -Wall -Wextra -Wno-implicit-fallthrough -std=c17 -O2

all: example

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

core.o: core.asm
	nasm -DN=2 -f elf64 -w+all -w+error -o core.o core.asm

test: core.o test.o test.c
	$(CC) -z noexecstack -o test core.o test.o -lpthread

example: core.o example.o example.c
	$(CC) -z noexecstack -o example core.o example.o -lpthread

clean:
	-rm -f *.o test example

.PHONY: all clean
