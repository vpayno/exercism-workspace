#!/usr/bin/gawk --lint --file

@include "awkunit"
@include "test-cases"
@include "grains"

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

function testGrains_total() {
    input = ""
    want = "18446744073709551615"

    # _ = split(input, a, " ")

    _debugTestPre()
    got = total()

    assertEquals(got, want)
    _debugTestPost()
}

function testGrains_0() {
    input = "0"
    want = "error:square must be between 1 and 64"

    # _ = split(input, a, " ")

    _debugTestPre()
    got = grains(input)

    assertEquals(got, want)
    _debugTestPost()
}

function testGrains_1() {
    input = "1"
    want = "1"

    # _ = split(input, a, " ")

    _debugTestPre()
    got = grains(input)

    assertEquals(got, want)
    _debugTestPost()
}

function testGrains_64() {
    input = "64"
    want = "9223372036854775808"

    # _ = split(input, a, " ")

    _debugTestPre()
    got = grains(input)

    assertEquals(got, want)
    _debugTestPost()
}

function casesGrains() {
    printf "Running %d test cases\n\n", length(cases)
    caseNum = 0

    # Associative arrays don't preserve insert order.
    for (key in cases) {
        input = key
        want = cases[key]

        # _ = split(input, a, " ")

        _debugTestPre()
        got = grains(input)

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
    testGrains_0()
    testGrains_1()
    testGrains_64()
    testGrains_total()

    # running tests with reduced duplication
    casesGrains()

    print "\n" passed " out of " testCount " tests passed!"

    # add exit here to keep it from looping
    exit 0
}
