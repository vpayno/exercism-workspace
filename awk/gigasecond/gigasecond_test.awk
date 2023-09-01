#!/usr/bin/gawk --lint --file

@include "awkunit"
@include "test-cases"
@include "gigasecond"

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

function testGigasecond_short() {
    input = "2011-04-25"
    want = "2043-01-01T01:46:40"

    _debugTestPre()
    got = gigasecond(input)

    assertEquals(got, want)
    _debugTestPost()
}

function testGigasecond_long() {
    input = "2015-01-24T22:00:00"
    want = "2046-10-02T23:46:40"

    _debugTestPre()
    got = gigasecond(input)

    assertEquals(got, want)
    _debugTestPost()
}

function casesGigasecond() {
    printf "Running %d test cases\n\n", length(cases)
    caseNum = 0

    # Associative arrays don't preserve insert order.
    for (key in cases) {
        input = key
        want = cases[key]

        _debugTestPre()
        got = gigasecond(input)

        assertEquals(got, want)
        _debugTestPost()
    }
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
    testGigasecond_short()
    testGigasecond_long()

    # running tests with reduced duplication
    casesGigasecond()

    print "\n" passed " out of " testCount " tests passed!"

    # add exit here to keep it from looping
    exit 0
}
