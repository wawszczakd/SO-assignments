CC = gcc
CFLAGS = -Wall -Wextra -Wno-implicit-fallthrough -std=c17 -O2

all: inverse_permutation_example

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

inverse_permutation.o: inverse_permutation.asm
	nasm -f elf64 -w+all -w+error -o inverse_permutation.o inverse_permutation.asm

inverse_permutation_example: inverse_permutation.o inverse_permutation_example.o inverse_permutation_example.c
	$(CC) -z noexecstack -o inverse_permutation_example inverse_permutation_example.o inverse_permutation.o

clean:
	-rm -f *.o inverse_permutation_example

.PHONY: all clean
