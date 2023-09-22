#!/usr/bin/gawk --lint --file
# test-cases.awk

#   key: input
# value: output

BEGIN {
    cases["2:10:1 0 1"]="5"
    cases["10:2:5"]="1 0 1"

    cases["2:10:1 2 1"]="error:found input digit, 2, that is larger than input base, 2"
    cases["2:10:1 -1 1"]="error:found negative input digit, -1"

    cases["1:10:"]="error:input base, 1, is less than or equal to 1"
    cases["10:1:"]="error:output base, 1, is less than or equal to 1"
    cases["10:2:"]=""

    # add exit here to keep it from waiting for input
    exit 0
}
