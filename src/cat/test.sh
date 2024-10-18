#!/bin/bash

SUCCESS=0
FAIL=0
DIFF_RES=""
FLAGS="b e n s t v"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
BASE="$(tput setaf 7)"

declare -a extra=(

    "-s test_case_cat.txt"
    "-b -e -n -s -t -v test_case_cat.txt"
    "-t test_case_cat.txt"
    "-n test_case_cat.txt"
    "-n -b test_case_cat.txt"
    "-s -n -e test_case_cat.txt"
    "-n test_case_cat.txt"
    "-n -e test_case_cat.txt"
    "-v test_case_cat.txt"
    "-b -e test_case_cat.txt"
    "-e -b test_case_cat.txt"
    "-s -t test_case_cat.txt"
    "-v -t test_case_cat.txt"
    "-t -b test_case_cat.txt"
    "-t -b test_case_cat.txt"
    "-t -b test_case_cat.txt"
    "-e test_case_cat.txt"
    "-n -b test_case_cat.txt"
    "-b -e -s test_case_cat.txt"
    "-s -v -t test_case_cat.txt"
    "-v -e -n test_case_cat.txt"
    "-e -t -b test_case_cat.txt"
    "-n -t -e test_case_cat.txt"
    "-b -t -n -s test_case_cat.txt"
    "-e -t -b -n test_case_cat.txt"
    "-n -e -s -v test_case_cat.txt"
    "-s -n -b -v test_case_cat.txt"
    "-v -e -b -n test_case_cat.txt"
    "-v -t -n -s test_case_cat.txt"
    "-b -t -s -e test_case_cat.txt"


)
testing() {
    t=$(echo $@ | sed "s/VAR/$var/")
    ./s21_cat $t > test_s21_cat.log
    cat $t > test_sys_cat.log
    DIFF_RES="$(diff -s test_s21_cat.log test_sys_cat.log)"
    RESULT="SUCCESS"
    if [ "$DIFF_RES" == "Files test_s21_cat.log and test_sys_cat.log are identical" ]
    then
      (( SUCCESS++ ))
        RESULT="SUCCESS"
    else
      (( FAIL++ ))
        RESULT="FAIL"
    fi
    echo "[${GREEN}${SUCCESS}${BASE}/${RED}${FAIL}${BASE}] ${RESULT} cat $t"

    rm test_s21_cat.log test_sys_cat.log
}

for i in "${extra[@]}"
do
    testing $i
done

echo "${GREEN}${SUCCESS} SUCCESS"
echo "${RED}${FAIL} FAIL"