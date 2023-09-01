#!/usr/bin/gawk --lint --file
# test-cases.awk

#   key: input
# value: output

BEGIN {
    cases["-9 9"]="0"
    cases["7.1 -7.1"]="0"

    cases["0 10"]="1"
    cases["-3.6 -3.6"]="1"
    cases["-7.0 7.0"]="1"

    cases["-5 0"]="5"
    cases["0.8 -0.8"]="5"
    cases["-3.5 3.5"]="5"
    cases["0.5 -4"]="5"

    cases["0 -1"]="10"
    cases["0 0"]="10"
    cases["-0.1 -0.1"]="10"
    cases["0.7 0.7"]="10"

    # add exit here to keep it from waiting for input
    exit 0
}
