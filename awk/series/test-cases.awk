#!/usr/bin/gawk --lint --file
# test-cases.awk

#   key: input
# value: output

BEGIN {
    # [span_len : number_sequence] = span_sequence
    cases["3:49142"]="491 914 142"
    cases["4:49142"]="4914 9142"

    cases["1:1"]="1"
    cases["1:12"]="1 2"
    cases["2:35"]="35"
    cases["2:9142"]="91 14 42"
    cases["3:777777"]="777 777 777 777"
    cases["5:918493904243"]="91849 18493 84939 49390 93904 39042 90424 04243"

    cases["6:12345"]="error: invalid length"
    cases["42:12345"]="error: invalid length"
    cases["0:12345"]="error: invalid length"
    cases["-1:123"]="error: invalid length"

    cases["1:"]="error: series cannot be empty"

    # add exit here to keep it from waiting for input
    exit 0
}
