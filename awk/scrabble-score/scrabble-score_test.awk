#!/usr/bin/gawk --bignum --lint --file

@include "awkunit"
@include "test-cases"
@include "scrabble-score"

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

function testScrabbleScore_zero() {
    input = ""
    want = ",0"

    # _ = split(input, a, " ")

    _debugTestPre()
    got = scrabbleScore(input)

    assertEquals(got, want)
    _debugTestPost()
}

function testScrabbleScore_one() {
    input = "a"
    want = "A,1"

    # _ = split(input, a, " ")

    _debugTestPre()
    got = scrabbleScore(input)

    assertEquals(got, want)
    _debugTestPost()
}

function testScrabbleScore_all() {
    input = "abcdefghijklmnopqrstuvwxyz"
    want = "ABCDEFGHIJKLMNOPQRSTUVWXYZ,87"

    # _ = split(input, a, " ")

    _debugTestPre()
    got = scrabbleScore(input)

    assertEquals(got, want)
    _debugTestPost()
}

function casesScrabbleScore() {
    printf "Running %d test cases\n\n", length(cases)
    caseNum = 0

    # Associative arrays don't preserve insert order.
    for (key in cases) {
        input = key
        want = cases[key]

        # _ = split(input, a, " ")

        _debugTestPre()
        got = scrabbleScore(input)

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
    testScrabbleScore_zero()
    testScrabbleScore_one()
    testScrabbleScore_all()

    # running tests with reduced duplication
    casesScrabbleScore()

    print "\n" passed " out of " testCount " tests passed!"

    # add exit here to keep it from looping
    exit 0
}
