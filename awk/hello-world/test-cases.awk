#!/usr/bin/gawk --lint --file
# test-cases.awk

#   key: input
# value: output

BEGIN {
    # key: input
    # value: expected output
    cases[""]="Hello, World!"

    # add exit here to keep it from waiting for input
    exit 0
}
