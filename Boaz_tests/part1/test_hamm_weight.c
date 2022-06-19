#include<stdio.h>
#define SIZE 1000

unsigned long read_input(unsigned long* codeword);
unsigned long hamming_weight(unsigned long* codeword, unsigned long len);
unsigned long negate_first_k(unsigned long codeword, unsigned char k);
unsigned long bring_balance_to_the_word(unsigned long* codeword, unsigned long len);
unsigned long codeword=0x234118;

int main() {
    printf("Hamming weight: %lu\n", hamming_weight(&codeword, 1));
    return 0;
}