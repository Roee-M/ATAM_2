#include<stdio.h>
#define SIZE 1000

unsigned long read_input(unsigned long* codeword);
unsigned long hamming_weight(unsigned long* codeword, unsigned long len);
unsigned long negate_first_k(unsigned long codeword, unsigned char k);
unsigned long bring_balance_to_the_word(unsigned long* codeword, unsigned long len);
unsigned long codeword[SIZE];

int main() {
    for(int i=0; i<SIZE; i++) {
        codeword[i] = (i+4)*i*(i-10);
    }
    printf("Hamming weight: %lu\n", hamming_weight(codeword, SIZE));
    return 0;
}