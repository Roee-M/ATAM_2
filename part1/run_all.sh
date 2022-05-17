#!/bin/bash

REDBG='\e[41m'
GREENBG='\e[42m'
BLUEBG='\e[44m'
NC='\033[0m' # No Color
STATUS=0

for ex in students_code.S; do
    printf "${BLUEBG}Running generated tests from Tests/$(basename $ex .asm)_tests/:${NC}\n"
    for gen_test in ./tests/inputs/test*; do
        if [ -f $gen_test ]; then
          
            cat $gen_test | xargs -n1 echo -n -e $1 > test
            ./run_test.sh $ex $gen_test
		    if [ $? -ne 0 ]; then
                STATUS=1
            fi
        fi
    done
done   


if [ $STATUS -eq 0 ]; then
    printf "${GREENBG}ALL PASSED!${NC}\n"
else
    printf "${REDBG}FAILED${NC}\n"
fi
