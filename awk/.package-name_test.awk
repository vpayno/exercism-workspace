#!/usr/bin/gawk --bignum --lint --file

@include "awkunit"
@include "test-cases"
@include "package-name"

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

function testPackageName_zero() {
    input = ""
    want = ""

    # _ = split(input, a, " ")

    _debugTestPre()
    got = packageName(input)

    assertEquals(got, want)
    _debugTestPost()
}

function casesPackageName() {
    printf "Running %d test cases\n\n", length(cases)
    caseNum = 0

    # orders array by index in for loop
    PROCINFO["sorted_in"] = "@ind_str_asc"

    # Associative arrays don't preserve insert order.
    for (key in cases) {
        input = key
        want = cases[key]

        # _ = split(input, a, " ")

        _debugTestPre()
        got = packageName(input)

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
    testPackageName_zero()

    # running tests with reduced duplication
    casesPackageName()

    print "\n" passed " out of " testCount " tests passed!"

    # add exit here to keep it from looping
    exit 0
}
