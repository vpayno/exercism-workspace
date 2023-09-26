#!/usr/bin/gawk --bignum --lint --file

@load "ordchr"

function is_number(line) {
    return line ~ /^[[:digit:]]+$/
}

function is_cmd_list(line) {
    return line ~ /^list$/
}

function is_cmd_latest(line) {
    return line ~ /^latest$/
}

function is_cmd_best(line) {
    return line ~ /^personalBest$/
}

function is_cmd_top_three(line) {
    return line ~ /^personalTopThree$/
}

function is_other(line) {
    return line !~ /^([[:digit:]]+|list|latest|personalBest|personalTopThree)$/
}

# side-effect central
# adds scores, latest and best to global scope
# NR only works in the main script, needs to be overridden in tests
function do_number(line) {
    i = NR ? NR : idx
    latest = scores[i] = line;
    best = (line > best) ? line : best
}

function do_list() {
    result = ""

    for (i in scores) {
        result = result scores[i] "\n"
    }

    return result
}

function do_latest() {
    return latest "\n"
}

function do_best() {
    return best "\n"
}

function do_top_three() {
    count = asort(scores, sorted_scores)

    result = ""

    for (i = count; i > count-3; i--) {
        result = result sorted_scores[i] "\n"
    }

    return result
}

BEGIN {
}

is_number($0) {
    do_number($0)
}

is_cmd_list($0) {
    print do_list()
}

is_cmd_latest($0) {
    print do_latest()
}

is_cmd_best($0) {
    print do_best()
}

is_cmd_top_three($0) {
    print do_top_three()
}

is_other($0) {
    print "error: invalid input [" $0 "], expecting unsigned integer or command" #> /dev/stderr
    exit 1
}

END {
}
