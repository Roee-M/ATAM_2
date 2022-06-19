#include<stdio.h>
#define SIZE 10000

unsigned long read_input(unsigned long* codeword);
unsigned long hamming_weight(unsigned long* codeword, unsigned long len);
unsigned long negate_first_k(unsigned long codeword, unsigned char k);
unsigned long bring_balance_to_the_word(unsigned long* codeword, unsigned long len);
unsigned long codeword[SIZE];

int main() {
    for(int i=0; i<SIZE; i++) {
        codeword[i] = (i+4)*i*(i-10);
    }
    printf("Hamming weight: %lu\n", hamming_weight((unsigned long*)codeword, SIZE));
    printf("After negating the first 7 bits of the first 8-byte: 0x%lx\n", negate_first_k(codeword[0], 7));
    printf("The index at which Knuth's algorithm stopped: %lu\n", bring_balance_to_the_word((unsigned long*)codeword, SIZE));
    printf("The balanced word: ");
    for(int i=0; i<SIZE; i++) {
        printf("0x%lx", codeword[i]);
        if(i==SIZE-1) printf("\n");
        else printf(", ");	
    }
    return 0;
}