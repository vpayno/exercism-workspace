#!/usr/bin/gawk --lint --file
# test-cases.awk

#   key: input
# value: output

BEGIN {
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
