#!/bin/bash

SUCCESS=0
FAIL=0
COUNTER=0
DIFF_RES=""
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
BASE="$(tput setaf 7)"

declare -a extra=(
    "-e for test_grep.txt"
    "-e for -e so test_grep.txt"
    "-e for -e so -e that -e is test_grep.txt"
    "-e for -e so -e that -e is test_grep.txt -n"
    "-e for -e so -e that -e is test_grep.txt -l"
    "-e for -e so -e that -e is test_grep.txt -h"
    "-e for -e so -e that -e is test_grep.txt -lhn"
    "-e for -e so -e that -e is test_grep.txt -lhnsi"
    "-e for -e so -e that -e is test_grep.txt -lhnsiv"
    "for test_grep.txt -o"
    "for test_grep.txt -on"
    "for test_grep.txt -oh"
    "for test_grep.txt -os"
    "for test_grep.txt -oi"
    "for test_grep.txt"
    "-e for -e so test_grep.txt -o"
    "-e for -e so test_grep.txt -on"
    "-e for -e so test_grep.txt -oh"
    "-e for -e so test_grep.txt -os"
    "-e for -e so test_grep.txt -oi"
    "-e for -e so test_grep.txt -v"
    "-e for -e so test_grep.txt -vh"
    "-e for -e so test_grep.txt -vi"
    "-n for test_grep.txt"
    "-n -e } test_grep.txt"
    "-ne = -e out test_grep.txt"
    "-e ^int test_grep.txt"
    "-nivh = test_grep.txt test_grep.txt"
    "-ie INT test_grep.txt"
    "-echar test_grep.txt test_grep.txt"
    "-ne = -e out test_grep.txt"
    "-iv int test_grep.txt"
    "-in int test_grep.txt"
    "-v test_grep.txt -e ank"
    "-in -l int test_grep.txt"
    "-ne ) test_grep.txt"
    "-l for test_grep.txt test_grep.txt"
    "-o -e brr test_grep.txt"
    "-v test_grep.txt -e ank"
    "-e = -e out test_grep.txt"
    "-f test_grep1.txt test_grep.txt"
    "-f test_grep1.txt test_grep.txt -h"
    "-f test_grep1.txt test_grep.txt -i"
    "-f test_grep1.txt test_grep.txt -v"
    "-f test_grep1.txt test_grep.txt -hns"
    "-f test_grep1.txt test_grep.txt -in"
    "-f test_grep1.txt test_grep.txt -inh"
    "-f test_grep1.txt test_grep.txt -inhs"
    "-f test_grep1.txt test_grep.txt -ov"
    "-f test_grep1.txt test_grep.txt -ivclnhs"
    "-f test_grep1.txt test_grep.txt -vi"
    "-f test_grep1.txt test_grep.txt -nivh"
    "-f test_grep1.txt test_grep.txt -ne"
)


testing()
{
    t=$(echo $@ | sed "s/VAR/$var/")
    ./s21_grep $t > test_s21_grep.log
    grep $t > test_sys_grep.log
    DIFF_RES="$(diff -s test_s21_grep.log test_sys_grep.log)"
    RESULT="SUCCESS"
    (( COUNTER++ ))
    if [ "$DIFF_RES" == "Files test_s21_grep.log and test_sys_grep.log are identical" ]
    then
      (( SUCCESS++ ))
        RESULT="SUCCESS"
    else
      (( FAIL++ ))
        RESULT="FAIL"
    fi
    echo "[${GREEN}${SUCCESS}${BASE}/${RED}${FAIL}${BASE}] ${GREEN}${RESULT}${BASE} grep $t"
    rm test_s21_grep.log test_sys_grep.log
}

# специфические тесты
for i in "${extra[@]}"
do
    var="-"
    testing $i
done

echo "${RED}FAIL: ${FAIL}${BASE}"
echo "${GREEN}SUCCESS: ${SUCCESS}${BASE}"
echo "ALL: $COUNTER"

