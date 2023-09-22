#!/usr/bin/gawk --bignum --lint --file

@include "awkunit"
@include "test-cases"
@include "all-your-base"

passed = 0
testCount = 0

function _debugTestPre() {
    printf "Test %s:\n", (passed + 1)
    printf "     input -> [%s]\n", input_base
    printf "    digits -> [%s]\n", input_digits
}

function _debugTestPost() {
    passed = passed + 1
    printf "    output -> [%s]\n", got
    printf "    result -> passed\n\n"
}

function testAllYourBase_2to10() {
    input_base = "2"
    output_base = "10"
    input_digits = "1 0 1"
    want = "5"

    # _ = split(input, a, " ")

    _debugTestPre()
    got = allYourBase(input_base, output_base, input_digits)

    assertEquals(got, want)
    _debugTestPost()
}

function testAllYourBase_10to2() {
    input_base = "10"
    output_base = "2"
    input_digits = "5"
    want = "1 0 1"

    # _ = split(input, a, " ")

    _debugTestPre()
    got = allYourBase(input_base, output_base, input_digits)

    assertEquals(got, want)
    _debugTestPost()
}

function casesAllYourBase() {
    printf "Running %d test cases\n\n", length(cases)
    caseNum = 0

    # orders array by index in for loop
    PROCINFO["sorted_in"] = "@ind_str_asc"

    # Associative arrays don't preserve insert order.
    for (key in cases) {
        input = key
        want = cases[key]

        _ = split(input, a, ":")

        input_base = a[1]
        output_base = a[2]
        input_digits = a[3]

        _debugTestPre()
        got = allYourBase(input_base, output_base, input_digits)

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
    testAllYourBase_2to10()
    testAllYourBase_10to2()

    # running tests with reduced duplication
    casesAllYourBase()

    print "\n" passed " out of " testCount " tests passed!"

    # add exit here to keep it from looping
    exit 0
}
