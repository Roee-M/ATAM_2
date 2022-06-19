#include<stdio.h>

unsigned long read_input(unsigned long* codeword);
unsigned long hamming_weight(unsigned long* codeword, unsigned long len);
unsigned long negate_first_k(unsigned long codeword, unsigned char k);
unsigned long bring_balance_to_the_word(unsigned long* codeword, unsigned long len);
unsigned long codeword[10000];

int main() {
	unsigned long len = read_input(codeword);
	printf("Input: ");
	for(int i=0; i<len; i++) {
		printf("0x%lx", codeword[i]);
		if(i==len-1) printf("\n");
		else printf(", ");	
	}
	return 0;
}