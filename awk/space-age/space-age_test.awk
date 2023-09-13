#!/usr/bin/gawk --bignum --lint --file

@include "awkunit"
@include "test-cases"
@include "space-age"

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

function testSpaceAge_zero() {
    input = ""
    want = "error:no planet or seconds given"

    # _ = split(input, a, " ")

    _debugTestPre()
    got = spaceAge(input)

    assertEquals(got, want)
    _debugTestPost()
}

function testSpaceAge_sun() {
    input = "Sun 680804807"
    want = "error:not a planet"

    # _ = split(input, a, " ")

    _debugTestPre()
    got = spaceAge(input)

    assertEquals(got, want)
    _debugTestPost()
}

function testSpaceAge_earth() {
    input = "Earth 1000000000"
    want = "31.69"

    # _ = split(input, a, " ")

    _debugTestPre()
    got = spaceAge(input)

    assertEquals(got, want)
    _debugTestPost()
}

function casesSpaceAge() {
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
        got = spaceAge(input)

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
    testSpaceAge_zero()
    testSpaceAge_sun()
    testSpaceAge_earth()

    # running tests with reduced duplication
    casesSpaceAge()

    print "\n" passed " out of " testCount " tests passed!"

    # add exit here to keep it from looping
    exit 0
}
