#!/usr/bin/gawk --lint --file
# test-cases.awk

#   key: input
# value: output

BEGIN {
    # bc <<< "( (4*2) + 5 + (3*2) + 9 + (3*2) + 1 + (9*2-9) + 5 + (0) + 3 + (4*2) + 3 + (6*2-9) + 4 + (6*2-9) + 7) % 10"
    cases["4539 3195 0343 6467"]="true"
    # bc <<< "( (8*2-9) + 2 + (7*2-9) + 3 + (1*2) + 2 + (3*2) + 2 + (7*2-9) + 3 + (5*2-9) + 2 + (0) + 5 + (6*2-9) + 9 ) % 10"
    cases["8273 1232 7352 0569"]="false"

    cases["1"]="false"
    cases["0"]="false"
    cases["055 444 286"]="false"
    cases["8273 1232 7352 0569"]="false"
    cases["1 2345 6789 1234 5678 9012"]="false"
    cases["1 2345 6789 1234 5678 9013"]="false"
    cases["055a 444 285"]="false"
    cases["055-444-285"]="false"
    cases["055£ 444$ 285"]="false"
    cases[" 0"]="false"
    cases["055b 444 285"]="false"
    cases[":9"]="false"
    cases["59%59"]="false"

    cases["059"]="true"
    cases["59"]="true"
    cases["055 444 285"]="true"
    cases["095 245 88"]="true"
    cases["234 567 891 234"]="true"
    cases["0000 0"]="true"
    cases["091"]="true"
    cases["9999999999 9999999999 9999999999 9999999999"]="true"
    cases["109"]="true"

    # add exit here to keep it from waiting for input
    exit 0
}
