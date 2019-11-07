#!/bin/bash
#
# Testing framework
#
RED='\033[0;31m'
GREEN='\033[92m'
NOCOLOR='\033[0m'

PASS="[${GREEN}PASS${NOCOLOR}]"
FAIL="[${RED}FAIL${NOCOLOR}]"

function testing__fail()
{
    echo -e "${FAIL}"
}


function testing__pass()
{
    echo -e "${PASS}"
}

function testing__test_head()
{
    local decorator="------"

    if (( $# < 1 ))
    then
        echo "Error: test_head must be called with at least one parameter"
        echo ""
        echo "Usage: test_head test_name [test_number]"
        return 1
    fi

    local name=${1:-"Unknown Test"}
    local let ntest=0

    if (( $# == 2 )); then ntest=$2; fi
    
    if (( ntest == 0 ))
    then
        echo -e "$decorator Test: <$name> [$(date)] $decorator"
    else
        echo -e "$decorator Test $ntest: <$name> [$(date)] $decorator"
    fi

    return 0
}

function testing__run_test()
{
    local let ntest=0
    while [ -n "$1" ]
    do
        ntest=$((ntest+1))
        testing__test_head "$1" $ntest
        $1
        shift
    done
}
