#!/usr/bin/gawk --lint --file

@include "awkunit"
@include "test-cases"
@include "leap"

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

function testLeap_empty() {
    input = ""
    want = "error: you forgot to tell me the year"

    # _ = split(input, a, " ")

    _debugTestPre()
    got = leap(input)

    assertEquals(got, want)
    _debugTestPost()
}

function testLeap_negone() {
    input = "-1"
    want = "error: do BC years have leap years?"

    # _ = split(input, a, " ")

    _debugTestPre()
    got = leap(input)

    assertEquals(got, want)
    _debugTestPost()
}

function testLeap_zero() {
    input = "0"
    want = "error: there's no year zero"

    # _ = split(input, a, " ")

    _debugTestPre()
    got = leap(input)

    assertEquals(got, want)
    _debugTestPost()
}

function testLeap_is_leap() {
    input = "1996"
    want = "true"

    # _ = split(input, a, " ")

    _debugTestPre()
    got = leap(input)

    assertEquals(got, want)
    _debugTestPost()
}

function testLeap_not_leap() {
    input = "1997"
    want = "false"

    # _ = split(input, a, " ")

    _debugTestPre()
    got = leap(input)

    assertEquals(got, want)
    _debugTestPost()
}

function casesLeap() {
    printf "Running %d test cases\n\n", length(cases)
    caseNum = 0

    # Associative arrays don't preserve insert order.
    for (key in cases) {
        input = key
        want = cases[key]

        # _ = split(input, a, " ")

        _debugTestPre()
        got = leap(input)

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
    testLeap_empty()
    testLeap_negone()
    testLeap_zero()
    testLeap_is_leap()
    testLeap_not_leap()

    # running tests with reduced duplication
    casesLeap()

    print "\n" passed " out of " testCount " tests passed!"

    # add exit here to keep it from looping
    exit 0
}
