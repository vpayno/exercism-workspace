#!/usr/bin/gawk --lint --file

@include "awkunit"
@include "test-cases"
@include "luhn"

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

function test_reverse_string() {
    input = "0123456789"
    want = "9876543210"

    _debugTestPre()
    got = reverse_string(input)

    assertEquals(got, want)
    _debugTestPost()
}

function test_is_valid_empty() {
    input = ""
    want = "false"

    _debugTestPre()
    got = is_valid(input)

    assertEquals(got, want)
    _debugTestPost()
}

function test_is_valid_valid() {
    input = "123 456"
    want = "true"

    _debugTestPre()
    got = is_valid(input)

    assertEquals(got, want)
    _debugTestPost()
}

function test_is_valid_not_valid() {
    input = "abc 456"
    want = "false"

    _debugTestPre()
    got = is_valid(input)

    assertEquals(got, want)
    _debugTestPost()
}

function testLuhn_empty() {
    input = ""
    want = "false"

    # _ = split(input, a, " ")

    _debugTestPre()
    got = luhn(input)

    assertEquals(got, want)
    _debugTestPost()
}

function casesLuhn() {
    printf "Running %d test cases\n\n", length(cases)
    caseNum = 0

    # Associative arrays don't preserve insert order.
    for (key in cases) {
        input = key
        want = cases[key]

        # _ = split(input, a, " ")

        _debugTestPre()
        got = luhn(input)

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

    test_reverse_string()

    test_is_valid_empty()
    test_is_valid_valid()
    test_is_valid_not_valid()

    # running tests with a lot of duplication
    testLuhn_empty()

    # running tests with reduced duplication
    casesLuhn()

    print "\n" passed " out of " testCount " tests passed!"

    # add exit here to keep it from looping
    exit 0
}
