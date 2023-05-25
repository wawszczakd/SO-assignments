#include <assert.h>
#include <limits.h>
#include <stdbool.h>
#include <stddef.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

bool inverse_permutation(size_t n, int *p);

int main() {
	size_t n1 = 0;
	size_t n2 = 0x80000000; // INT_MAX + 1
	size_t n3 = 0x80000001; // INT_MAX + 2
	size_t n4 = 4;
	
	int *p1 = malloc(5 * sizeof(int));
	p1[0] = 2;
	p1[1] = 1;
	p1[2] = 3;
	p1[3] = 7;
	p1[4] = n2;
	
	int *p2 = malloc(4 * sizeof(int));
	p2[0] = 2;
	p2[1] = 1;
	p2[2] = 3;
	p2[3] = -1;
	
	int *p3 = malloc(4 * sizeof(int));
	p3[0] = 2;
	p3[1] = 1;
	p3[2] = 3;
	p3[3] = 0;
	
	int *p4 = malloc(6 * sizeof(int));
	p4[0] = 4;
	p4[1] = 5;
	p4[2] = 3;
	p4[3] = 0;
	p4[4] = 2;
	p4[5] = 5;
	
	// assert(inverse_permutation(n1, p1) == false);
	// assert(inverse_permutation(n2, p1) == false);
	// assert(inverse_permutation(n3, p1) == false);
	// assert(inverse_permutation(n4, p1) == false);
	// assert(inverse_permutation(n4, p2) == false);
	assert(inverse_permutation(n4, p3) == true);
	// assert(inverse_permutation(6, p4) == false);
	
	// for (size_t i = 0; i < n4; i++) {
	// 	printf("%d %d\n", p1[i], p1[i] ^ 0x80000000);
	// }
	
	// for (size_t i = 0; i < n4; i++) {
	// 	printf("%d %d\n", p2[i], p2[i] ^ 0x80000000);
	// }
	
	for (size_t i = 0; i < n4; i++) {
		printf("%d %d\n", p3[i], p3[i] ^ 0x80000000);
	}
	
	// for (size_t i = 0; i < 6; i++) {
	// 	printf("%d %d\n", p4[i], p4[i] ^ 0x80000000);
	// }
	
	free(p1);
	free(p2);
	free(p3);
}