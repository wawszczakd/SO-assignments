#include <assert.h>
#include <inttypes.h>
#include <pthread.h>
#include <stddef.h>
#include <stdio.h>

uint64_t core(uint64_t n, char const *p);

uint64_t get_value(uint64_t n) {
	return n + 1;
}

void put_value(uint64_t n, uint64_t v) {
	printf("n = %zu, v = %zu\n", n, v);
}

int main() {
	printf("%zu\n", core(0, "469P"));
}
