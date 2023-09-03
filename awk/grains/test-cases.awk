#!/usr/bin/gawk --lint --file
# test-cases.awk

#   key: input
# value: output

BEGIN {
    cases["0"]="error:square must be between 1 and 64"
    cases["65"]="error:square must be between 1 and 64"

    cases["1"]="1"
    cases["2"]="2"
    cases["3"]="4"
    cases["4"]="8"
    cases["16"]="32768"
    cases["32"]="2147483648"
    cases["64"]="9223372036854775808"

    cases["total"]="18446744073709551615"

    # add exit here to keep it from waiting for input
    exit 0
}
