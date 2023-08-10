#!/usr/bin/awk --lint --file

@include "awkunit"
@include "test-cases"
@include "two-fer"

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

function testTwoFer_default() {
    want = "One for you, one for me."
    got = twoFer("")
    assertEquals(want, got)
    passed = passed + 1
}

function testTwoFer_one() {
    want = "One for Alice, one for me."
    got = twoFer("Alice")
    assertEquals(want, got)
    passed = passed + 1
}

function testTwoFer_two() {
    want = "One for Mary Ann, one for me."
    got = twoFer("Mary Ann")
    assertEquals(want, got)
    passed = passed + 1
}

function casesTwoFer() {
    printf "Running %d test cases\n\n", length(cases)
    caseNum = 0

    # Associative arrays don't preserve insert order.
    for (key in cases) {
        input = key
        want = cases[key]

        _debugTestPre()
        got = twoFer(input)

        assertEquals(want, got)
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

    testTwoFer_default()
    testTwoFer_one()
    testTwoFer_two()

    casesTwoFer()

    print "\n" passed " out of " testCount " tests passed!" > "/dev/stderr"

    # add exit here to keep it from looping
    exit 0
}
