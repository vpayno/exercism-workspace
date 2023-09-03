#!/usr/bin/gawk --bignum --lint --file

@include "awkunit"
@include "test-cases"
@include "triangle"

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

function testTriangle_to_faux_bool_one() {
    input = 1 # not-zero is true
    want = "true"

    _debugTestPre()
    got = to_faux_bool(input)

    assertEquals(got, want)
    _debugTestPost()
}

function testTriangle_to_faux_bool_two() {
    input = 0 # zero is false
    want = "false"

    _debugTestPre()
    got = to_faux_bool(input)

    assertEquals(got, want)
    _debugTestPost()
}

function testTriangle_equilateral_one() {
    input = "1 1 1"
    want = "true"

    # _ = split(input, a, " ")

    type = "equilateral"

    _debugTestPre()
    got = triangle(input)

    assertEquals(got, want)
    _debugTestPost()
}

function testTriangle_equilateral_two() {
    input = "1 2 1"
    want = "false"

    # _ = split(input, a, " ")

    type = "equilateral"

    _debugTestPre()
    got = triangle(input)

    assertEquals(got, want)
    _debugTestPost()
}

function testTriangle_isosceles_one() {
    input = "4 3 4"
    want = "true"

    # _ = split(input, a, " ")

    type = "isosceles"

    _debugTestPre()
    got = triangle(input)

    assertEquals(got, want)
    _debugTestPost()
}

function testTriangle_isosceles_two() {
    input = "1 3 1"
    want = "false"

    # _ = split(input, a, " ")

    type = "isosceles"

    _debugTestPre()
    got = triangle(input)

    assertEquals(got, want)
    _debugTestPost()
}

function testTriangle_scalene_one() {
    input = "5 4 6"
    want = "true"

    # _ = split(input, a, " ")

    type = "scalene"

    _debugTestPre()
    got = triangle(input)

    assertEquals(got, want)
    _debugTestPost()
}

function testTriangle_scalene_two() {
    input = "4 3 3"
    want = "false"

    # _ = split(input, a, " ")

    type = "scalene"

    _debugTestPre()
    got = triangle(input)

    assertEquals(got, want)
    _debugTestPost()
}

function casesTriangle_equilateral() {
    printf "Running %d test cases\n\n", length(equilateral_cases)
    caseNum = 0

    # Associative arrays don't preserve insert order.
    for (key in equilateral_cases) {
        input = key
        want = equilateral_cases[key]

        # _ = split(input, a, " ")

        type = "equilateral"

        _debugTestPre()
        got = triangle(input)

        assertEquals(got, want)
        _debugTestPost()
    }
}

function casesTriangle_isosceles() {
    printf "Running %d test cases\n\n", length(isosceles_cases)
    caseNum = 0

    # Associative arrays don't preserve insert order.
    for (key in isosceles_cases) {
        input = key
        want = isosceles_cases[key]

        # _ = split(input, a, " ")

        type = "isosceles"

        _debugTestPre()
        got = triangle(input)

        assertEquals(got, want)
        _debugTestPost()
    }
}

function casesTriangle_scalene() {
    printf "Running %d test cases\n\n", length(scalene_cases)
    caseNum = 0

    # Associative arrays don't preserve insert order.
    for (key in scalene_cases) {
        input = key
        want = scalene_cases[key]

        # _ = split(input, a, " ")

        type = "scalene"

        _debugTestPre()
        got = triangle(input)

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

    testCount = testCount + length(equilateral_cases) + length(isosceles_cases) + length(scalene_cases)

    # running tests with a lot of duplication or not covered by test-cases file
    testTriangle_to_faux_bool_one()
    testTriangle_to_faux_bool_two()
    testTriangle_equilateral_one()
    testTriangle_equilateral_two()
    testTriangle_isosceles_one()
    testTriangle_isosceles_two()
    testTriangle_scalene_one()
    testTriangle_scalene_two()

    # running tests with reduced duplication
    casesTriangle_equilateral()
    casesTriangle_isosceles()
    casesTriangle_scalene()

    print "\n" passed " out of " testCount " tests passed!"

    # add exit here to keep it from looping
    exit 0
}
