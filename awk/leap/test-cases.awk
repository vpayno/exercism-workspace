#!/usr/bin/gawk --lint --file
# test-cases.awk

#   key: input
# value: output

BEGIN {
    cases[""]="error: you forgot to tell me the year" # wow, this works with a warning
    cases["0"]="error: there's no year zero"
    cases["-1"]="error: do BC years have leap years?"

    cases["1800"]="false"
    cases["1900"]="false"
    cases["1970"]="false"
    cases["1997"]="false"
    cases["2015"]="false"
    cases["2100"]="false"

    cases["1960"]="true"
    cases["1996"]="true"
    cases["1996"]="true"
    cases["2000"]="true"
    cases["2400"]="true"

    # add exit here to keep it from waiting for input
    exit 0
}
