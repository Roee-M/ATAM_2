#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

YOUR_ASM=$1
TEST=$2
TEST_NAME=$(basename -- "$TEST")
TESTS_OUTPUT=`pwd`/tests/outputs
gcc get_path.o main.c "$YOUR_ASM"  -o  main.out
mkdir -p $TESTS_OUTPUT

	if [ -f "main.out" ]; then
           
	    ./main.out  > ./tests/outputs/${TEST_NAME%.*}.out
		if [ "`diff -q --strip-trailing-cr tests/expected/"${TEST_NAME%.*}"_exp.out tests/outputs/${TEST_NAME%.*}.out`" ]; then
		    printf "${YOUR_ASM} tested with ${TEST_NAME}: ${RED}FAIL${NC}\n"
			STATUS=1
			
		else
			printf "${YOUR_ASM} tested with ${TEST_NAME}: ${GREEN}PASS${NC}\n"
			STATUS=0
		fi
	else
		printf "${YOUR_ASM} could not be created (ld stage) with ${TEST_NAME}: ${RED}FAIL${NC}\n"
		STATUS=1
	fi



exit ${STATUS}
