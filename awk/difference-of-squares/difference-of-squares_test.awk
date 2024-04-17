#!/usr/bin/gawk --bignum --lint --file

@include "awkunit"
@include "test-cases"
@include "difference-of-squares"

passed = 0
testCount = 0

function _debugTestPre() {
    printf "Test %s: %s\n", (passed + 1), test_name
    printf "     input -> [%s]\n", input
}

function _debugTestPost() {
    passed = passed + 1
    printf "    output -> [%s]\n", got
    printf "    result -> passed\n\n"
}

function casesDifferenceOfSquares() {
    printf "Running %d test cases\n\n", length(cases)
    caseNum = 0

    # orders array by index in for loop
    PROCINFO["sorted_in"] = "@ind_str_asc"

    # Associative arrays don't preserve insert order.
    for (key in cases) {
        input = key
        want = cases[key]

        test_name = "[" input "]"

        _ = split(input, part, ",")

        _debugTestPre()

        got = 0

        if (part[1] == "difference") {
            got = differenceOfSquares(part[2])
        } else if (part[1] == "square_of_sum") {
            got = squareOfSum(part[2])
        } else if (part[1] == "sum_of_squares") {
            got = sumOfSquares(part[2])
        }

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

    # running tests with reduced duplication
    casesDifferenceOfSquares()

    print "\n" passed " out of " testCount " tests passed!"

    # add exit here to keep it from looping
    exit 0
}
