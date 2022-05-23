#! /bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
REDBG='\e[41m'
GREENBG='\e[42m'
BLUEBG='\e[44m'
NC='\033[0m' # No Color

expect_return()
{
    bin=$1
    expected=$2
    $bin
    result=$?
    if [ $result -eq $expected ]; then
        echo -e "${GREEN}PASSED${NC}"
        return 0
    else
        echo -e "${RED}FAILED${NC}, result=$result"
        return 1
    fi
}

test1()
{
    echo "testing bad_inst when loaded"
    ./bad_inst
    result=$?
    if [ $result -eq 35 ]; then
        echo -e "${GREEN}PASSED${NC}"
    else
        echo -e "${RED}FAILED${NC}, result=$result"
    fi
    echo "---------------------------------------"
}

test2()
{
    echo "testing bad_inst_2 when loaded"
    ./bad_inst_2
    result=$?
    if [ $result -eq 132 ]; then
        echo -e "${GREEN}PASSED${NC}"
    else
        echo -e "${RED}FAILED${NC}, result=$result"
    fi
    echo "---------------------------------------"
}

test3()
{
    echo "testing bad_inst_3 when loaded"
    ./bad_inst_3
    result=$?
    if [ $result -eq 6 ]; then
        echo -e "${GREEN}PASSED${NC}"
    else
        echo -e "${RED}FAILED${NC}, result=$result"
    fi
    echo "---------------------------------------"
}
status=0
echo "Testing before load:"
expect_return ./bad_inst 132 || status=1
expect_return ./bad_inst_2 132 || status=1
expect_return ./bad_inst_3 132 || status=1
echo "---------------------------------------"
insmod ili.ko
echo "Testing after load:"
expect_return ./bad_inst 35 || status=1
expect_return ./bad_inst_2 132 || status=1
expect_return ./bad_inst_3 6 || status=1
echo "---------------------------------------"
rmmod ili.ko
echo "Testing after unload:"
expect_return ./bad_inst 132 || status=1
expect_return ./bad_inst_2 132 || status=1
expect_return ./bad_inst_3 132 || status=1


if [ $status -eq 0 ]; then
    echo -e "${GREENBG}ALL PASSED!${NC}"
    exit 0
else
    echo -e "${REDBG}FAILED${NC}"
    exit 1
fi
