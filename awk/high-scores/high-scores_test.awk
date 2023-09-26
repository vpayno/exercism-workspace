#!/usr/bin/gawk --bignum --lint --file

@include "awkunit"
@include "test-cases"
@include "high-scores"

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

function testHighScores_isNumber() {
    test_name = "is_number()"
    input = "123"
    want = "true"

    _debugTestPre()
    got = is_number(input) ? "true" : "false"

    assertEquals(got, want)
    _debugTestPost()
}

function testHighScores_isCmdList() {
    test_name = "is_cmd_list()"
    input = "123"
    want = "true"

    _debugTestPre()
    got = is_number(input) ? "true" : "false"

    assertEquals(got, want)
    _debugTestPost()
}

function testHighScores_isCmdLatest() {
    test_name = "is_cmd_latest()"
    input = "123"
    want = "true"

    _debugTestPre()
    got = is_number(input) ? "true" : "false"

    assertEquals(got, want)
    _debugTestPost()
}

function testHighScores_isCmdBest() {
    test_name = "is_cmd_best()"
    input = "123"
    want = "true"

    _debugTestPre()
    got = is_number(input) ? "true" : "false"

    assertEquals(got, want)
    _debugTestPost()
}

function testHighScores_isCmdTopThree() {
    test_name = "is_cmd_top_three()"
    input = "123"
    want = "true"

    _debugTestPre()
    got = is_number(input) ? "true" : "false"

    assertEquals(got, want)
    _debugTestPost()
}

function casesHighScores() {
    printf "Running %d test cases\n\n", length(cases)
    caseNum = 0

    # orders array by index in for loop
    PROCINFO["sorted_in"] = "@ind_str_asc"

    # Associative arrays don't preserve insert order.
    for (key in cases) {
        input = key
        want = cases[key]

        test_name = "[" input "]"

        a_len = split(input, a, " ")

        _debugTestPre()

        got = ""

        # add scores, latest and best to global score
        for (idx = 1; idx <= a_len; idx++) {
            line = a[idx]

            if (is_number(line)) {
                do_number(line)
            } else if (is_cmd_list(line)) {
                got = got do_list()
            } else if (is_cmd_latest(line)) {
                got = got do_latest()
            } else if (is_cmd_best(line)) {
                got = got do_best()
            } else if (is_cmd_top_three(line)) {
                got = got do_top_three()
            }
        }

        assertEquals(length(a), a_len)
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

    # running tests without test cases
    testHighScores_isNumber()
    testHighScores_isCmdList()
    testHighScores_isCmdLatest()
    testHighScores_isCmdBest()
    testHighScores_isCmdTopThree()

    # running tests with test cases
    casesHighScores()

    print "\n" passed " out of " testCount " tests passed!"

    # add exit here to keep it from looping
    exit 0
}
