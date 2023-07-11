#include <stdbool.h>
#include <stddef.h>

bool inverse_permutation(size_t n, int *p) {
	if (n == 0 || n > (size_t) 0x80000000) { // INT_MAX + 1
		return false;
	}
	
	for (size_t i = 0; i < n; i++) {
		if (p[i] < 0 || (size_t) p[i] >= n) {
			return false;
		}
	}
	
	for (size_t i = 0; i < n; i++) {
		if (p[i] >= 0) {
			size_t nxt;
			for (size_t j = p[i]; j != i; j = nxt) {
				if (p[j] < 0) {
					for (size_t k = 0; k < n; k++) {
						if (p[k] < 0) {
							p[k] ^= 0x80000000;
						}
					}
					
					return false;
				}
				
				nxt = p[j];
				p[j] ^= 0x80000000;
			}
			
			p[i] ^= 0x80000000;
		}
	}
	
	for (size_t i = 0; i < n; i++) {
		if (p[i] < 0) {
			p[i] ^= 0x80000000;
			
			size_t prv = i, nxt;
			for (size_t j = p[i]; j != i; j = nxt) {
				nxt = p[j] ^ 0x80000000;
				p[j] = prv;
				prv = j;
			}
			
			p[i] = prv;
		}
	}
	
	return true;
}
