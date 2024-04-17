#!/usr/bin/gawk --lint --file
# test-cases.awk

#   key: input
# value: output

BEGIN {
    cases["square_of_sum,1"]="1"
    cases["square_of_sum,100"]="225"
    cases["square_of_sum,100"]="25502500"
    cases["sum_of_squares,1"]="1"
    cases["sum_of_squares,5"]="55"
    cases["sum_of_squares,100"]="338350"
    cases["difference,1"]="0"
    cases["difference,5"]="170"
    cases["difference,100"]="25164150"

    # add exit here to keep it from waiting for input
    exit 0
}
