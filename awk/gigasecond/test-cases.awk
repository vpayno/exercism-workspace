#!/usr/bin/gawk --lint --file
# test-cases.awk

#   key: input
# value: output

BEGIN {
    cases["2011-04-25"]="2043-01-01T01:46:40"
    cases["1977-06-13"]="2009-02-19T01:46:40"
    cases["1959-07-19"]="1991-03-27T01:46:40"
    cases["2015-01-24T22:00:00"]="2046-10-02T23:46:40"
    cases["2015-01-24T23:59:59"]="2046-10-03T01:46:39"

    # add exit here to keep it from waiting for input
    exit 0
}
