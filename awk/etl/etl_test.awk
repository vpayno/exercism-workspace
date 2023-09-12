#!/usr/bin/gawk --bignum --lint --file

@include "awkunit"
@include "etl"

passed = 0
testCount = 0

function _debugTestPre() {
    printf "Test %s:\n", (passed + 1)
    printf "     input -> [%s]\n", input
}

function _debugTestPost() {
    passed = passed + 1
    printf "    output -> [%s]\n", got
    printf "    result -> passed\n\n"
}

function testEtl() {
    want = "a,1\ne,1\ni,1\no,1\nu,1\n"

    # _ = split(input, a, " ")

    _debugTestPre()
    NF = 6
    $1 = 1
    $2 = "A"
    $3 = "E"
    $4 = "I"
    $5 = "O"
    $6 = "U"
    etl() # creates scores
    got = prettyEtl() # uses scores

    assertEquals(got, want)
    _debugTestPost()
}

BEGIN {
    exit 0
}

END {
    cmd = "grep --no-filename --count ^function\\ test *_test.awk"
    cmd | getline testCount

    printf "\nRunning %d tests...\n\n", testCount

    testCount = testCount + length(cases)

    # running tests with a lot of duplication
    testEtl()

    print "\n" passed " out of " testCount " tests passed!"

    # add exit here to keep it from looping
    exit 0
}
