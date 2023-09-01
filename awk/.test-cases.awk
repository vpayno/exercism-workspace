#!/usr/bin/gawk --lint --file
# test-cases.awk

#   key: input
# value: output

BEGIN {
    cases[""]="" # wow, this works with a warning

    # add exit here to keep it from waiting for input
    exit 0
}
