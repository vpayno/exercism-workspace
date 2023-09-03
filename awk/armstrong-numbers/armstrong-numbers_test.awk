#!/usr/bin/gawk --lint --file

@include "awkunit"
@include "test-cases"
@include "armstrong-numbers"

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

function testlog10_5() {
    input = "12345"
    want = "4"

    # _ = split(input, a, " ")

    _debugTestPre()
    got = log10(input)

    assertEquals(got, want)
    _debugTestPost()
}

function testArmstrongNumbers_true() {
    input = "153"
    want = "true"

    # _ = split(input, a, " ")

    _debugTestPre()
    got = armstrong_numbers(input)

    assertEquals(got, want)
    _debugTestPost()
}

function testArmstrongNumbers_false() {
    input = "154"
    want = "false"

    # _ = split(input, a, " ")

    _debugTestPre()
    got = armstrong_numbers(input)

    assertEquals(got, want)
    _debugTestPost()
}

function casesArmstrongNumbers() {
    printf "Running %d test cases\n\n", length(cases)
    caseNum = 0

    # Associative arrays don't preserve insert order.
    for (key in cases) {
        input = key
        want = cases[key]

        # _ = split(input, a, " ")

        _debugTestPre()
        got = armstrong_numbers(input)

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

    testlog10_5()

    # running tests with a lot of duplication
    testArmstrongNumbers_true()
    testArmstrongNumbers_false()

    # running tests with reduced duplication
    casesArmstrongNumbers()

    print "\n" passed " out of " testCount " tests passed!"

    # add exit here to keep it from looping
    exit 0
}
