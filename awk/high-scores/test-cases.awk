#!/usr/bin/gawk --lint --file
# test-cases.awk

#   key: input
# value: output

BEGIN {
    cases["30 50 20 70 list"]="30\n50\n20\n70\n"
    cases["30 50 20 70 personalBest"]="70\n"
    cases["30 50 20 70 personalTopThree"]="70\n50\n30\n"
    cases["30 50 20 70 latest"]="70\n"
    cases["30 50 20 70 personalTopThree latest"]="70\n50\n30\n70\n"

    # add exit here to keep it from waiting for input
    exit 0
}
