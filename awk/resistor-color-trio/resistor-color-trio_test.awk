#!/usr/bin/gawk --bignum --lint --file

@include "awkunit"
@include "test-cases"
@include "resistor-color-trio"

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

function testResistorColorTrio_zero() {
    input = "one two three"
    want = "error:invalid color"

    # _ = split(input, a, " ")

    _debugTestPre()
    got = resistorColorTrio(input)

    assertEquals(got, want)
    _debugTestPost()
}

function testResistorColorTrio_one() {
    input = "orange orange black"
    want = "33 ohms"

    # _ = split(input, a, " ")

    _debugTestPre()
    got = resistorColorTrio(input)

    assertEquals(got, want)
    _debugTestPost()
}

function testResistorColorTrio_two() {
    input = "orange orange orange"
    want = "33 kiloohms"

    # _ = split(input, a, " ")

    _debugTestPre()
    got = resistorColorTrio(input)

    assertEquals(got, want)
    _debugTestPost()
}

function casesResistorColorTrio() {
    printf "Running %d test cases\n\n", length(cases)
    caseNum = 0

    # Associative arrays don't preserve insert order.
    for (key in cases) {
        input = key
        want = cases[key]

        # _ = split(input, a, " ")

        _debugTestPre()
        got = resistorColorTrio(input)

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
    testResistorColorTrio_zero()
    testResistorColorTrio_one()
    testResistorColorTrio_two()

    # running tests with reduced duplication
    casesResistorColorTrio()

    print "\n" passed " out of " testCount " tests passed!"

    # add exit here to keep it from looping
    exit 0
}
