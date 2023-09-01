#!/usr/bin/gawk --lint --file

function gigasecond(time_stamp) {
    # our constants
    GIGASECOND = 10^9
    USE_UTC = 1

    # replace delimiters with spaces for mktime()
    input_lhs = time_stamp
    gsub(/[-:T]/, " ", input_lhs)

    input_rhs = ""

    if (length(input_lhs) <= 10) {
        input_rhs = " 00 00 00"
    }

    input = input_lhs input_rhs

    # https://www.gnu.org/software/gawk/manual/html_node/Time-Functions.html
    time_seconds = mktime(input, USE_UTC)


    # https://www.gnu.org/software/gawk/manual/html_node/Time-Functions.html
    return strftime("%FT%T", time_seconds + GIGASECOND, USE_UTC)
}

BEGIN {
}

{
    print gigasecond($1)
}

END {
}
