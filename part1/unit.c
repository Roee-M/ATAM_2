/*
Instructions:
    1. Save this file in part1 directory
    2. From terminal: gcc get_path.o students_code.S unit.c -o unit.out
    3. From terminal: ./unit.out
    4. In case of success nothing will be printed.
*/
#include <stdio.h>
unsigned long read_input(unsigned long* codeword);
unsigned long hamming_weight(unsigned long* codeword, unsigned long len);
unsigned long negate_first_k(unsigned long codeword, unsigned char k);
unsigned long bring_balance_to_the_word(unsigned long* codeword, unsigned long len);

static void TestPdf()
{
    unsigned long codeword[500];
    unsigned long len = read_input(codeword); /* 1 */
    if(2!= len)printf("TestPdf 1) read_input Failed because len ==  %lu and not 2\n", len);

    unsigned char before[16] = {0xFF, 0xF0, 0x00, 0x00, 0xFF, 0x00, 0xFF, 0x00,
                                0xFE, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00};

    unsigned char after[16] = {0x00, 0x0F, 0xFF, 0xFF, 0x00, 0xFF, 0x00, 0xFF,
                                0x01, 0xFF, 0xFF, 0x07, 0xFF, 0x00, 0x00, 0x00};

    unsigned char*const p = (unsigned char*)codeword;
    unsigned long i = 0;
    while ( i < len*8)
    {
        if (p[i] != before[i]) printf("Failed before at char index %lu\n", i);
        ++i;
    }

    unsigned long ans;
    if(43 != (ans = hamming_weight(codeword, len))) /* 2 */
        printf("TestPdf 2) hamming_weight failed. ans == %lu and not 43.\n", ans);

    if(0xFF00FF0000F0E0 != (ans = negate_first_k(codeword[0], 5))) /* 3 */
        printf("TestPdf 3) negate_first_k failed. ans == %lX ans not 0xFF00FF0000F0E0\n", ans);

    if(91 != (ans = bring_balance_to_the_word(codeword, len))) /* 4 */
        printf("TestPdf Failed because bitsIndex ==  %lu and not 91\n", ans);

    i = 0;
    while ( i < len*8)
    {
        if (p[i] != after[i]) 
            printf("TestPdf Failed after at char index %lu, because == %02X and not %02X\n", i, p[i], after[i]);
        ++i;
    }
}

static void PrintByteByte(const unsigned char* begin, unsigned long len)
{
    unsigned long i = 0;
    while ( i < len * 8)
    {
        printf("%02X ", ((unsigned char*)begin)[i]);
        ++i;
        if (i % 8== 0)
        {
            printf("\n");
        }
    }       
}

static void TestOneWord()
{
    const unsigned long n = 1;
    unsigned long w[] = {0xFFFFFFFE};
    unsigned long ans = bring_balance_to_the_word(w, n);
    if (ans!=1)printf("TestOneWord Failed because ans == %lu and not 1\n", ans);
    // PrintByteByte((unsigned char*)w,n);
}

static void TestTwoWords()
{
    const unsigned long n = 2;
    unsigned long w[] = {0xFFFFFFFFFFFFFFFE, 0x0};
    unsigned long ans = bring_balance_to_the_word(w, n);
    if (ans!=1)printf("TestTwoWords Failed because ans == %lu and not 1\n", ans);
    // PrintByteByte((unsigned char*)w,n);
}

static void TestTwoWordsPdf()
{
    const unsigned long n = 2;
    unsigned char before[16] = {0xFF, 0xF0, 0x00, 0x00, 0xFF, 0x00, 0xFF, 0x00,
                                0xFE, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00};
    unsigned long ans = bring_balance_to_the_word((unsigned long*)before, n);
    if (ans!=91)printf("TestTwoWordsPdf Failed because ans == %lu and not 91\n", ans);
    // PrintByteByte((unsigned char*)before,n);
}

static void TestHammingWeight()
{
    const unsigned long n = 2;
    unsigned char w[2*8] = {0xFF, 0xF0, 0x00, 0x00, 0xFF, 0x00, 0xFF, 0xE0,
                                0xFF, 0x00, 0x01, 0x00, 0xFF, 0x00, 0x00, 0xE0};
    unsigned long ans = hamming_weight((unsigned long*)w, n);
    if (ans != 51)printf("err TestHammingWeight\n"); 
}

static void TestHammingWeight2()
{
    const unsigned long n = 2;
    unsigned char after[16] = {0x00, 0x0F, 0xFF, 0xFF, 0x00, 0xFF, 0x00, 0xFF,
                                0x01, 0xFF, 0xFF, 0x07, 0xFF, 0x00, 0x00, 0x00};
    unsigned long ans = hamming_weight((unsigned long*)after, n);
    if (ans != 64)printf("err TestHammingWeight2\n"); 
}
 
/* 5 tests*/
int main(void)
{
    TestPdf();
    TestOneWord();
    TestTwoWords();
/*    TestTwoWordsPdf();
    TestHammingWeight();
    TestHammingWeight2();*/
    return 0;
}
