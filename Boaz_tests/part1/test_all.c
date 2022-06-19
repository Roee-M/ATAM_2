#include<stdio.h>
#define SIZE 10000

unsigned long read_input(unsigned long* codeword);
unsigned long hamming_weight(unsigned long* codeword, unsigned long len);
unsigned long negate_first_k(unsigned long codeword, unsigned char k);
unsigned long bring_balance_to_the_word(unsigned long* codeword, unsigned long len);
unsigned long codeword[SIZE];

int main() {
    unsigned long len = read_input(codeword);
    printf("Input: ");
    for(int i=0; i<len; i++) {
        printf("0x%lx", codeword[i]);
        if(i==len-1) printf("\n");
        else printf(", ");	
    }
    printf("Hamming weight: %lu\n", hamming_weight((unsigned long*)codeword, len));
    printf("After negating the first 7 bits of the first 8-byte: 0x%lx\n", negate_first_k(codeword[0], 7));
    printf("The index at which Knuth's algorithm stopped: %lu\n", bring_balance_to_the_word((unsigned long*)codeword, len));
    printf("The balanced word: ");
    for(int i=0; i<len; i++) {
        printf("0x%lx", codeword[i]);
        if(i==len-1) printf("\n");
        else printf(", ");	
    }
    return 0;
}