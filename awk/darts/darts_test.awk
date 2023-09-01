#!/usr/bin/gawk --lint --file

@include "awkunit"
@include "test-cases"
@include "darts"

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

function test_hypot() {
    x = "2.5"
    y = "5.5"

    want = "6.04152"

    _debugTestPre()
    got = hypot(x, y)

    assertEquals(got, want)
    _debugTestPost()
}

function testDarts_inner() {
    input = "0 0"
    want = "10"

    _ = split(input, a, " ")
    x = a[1]
    y = a[2]

    _debugTestPre()
    got = darts(x, y)

    assertEquals(got, want)
    _debugTestPost()
}

function testDarts_middle() {
    input = "2.5 2.5"
    want = "5"

    _ = split(input, a, " ")
    x = a[1]
    y = a[2]

    _debugTestPre()
    got = darts(x, y)

    assertEquals(got, want)
    _debugTestPost()
}

function testDarts_outer() {
    input = "6.5 6.5"
    want = "1"

    _ = split(input, a, " ")
    x = a[1]
    y = a[2]

    _debugTestPre()
    got = darts(x, y)

    assertEquals(got, want)
    _debugTestPost()
}

function testDarts_outside() {
    input = "9 9"
    want = "0"

    _ = split(input, a, " ")
    x = a[1]
    y = a[2]

    _debugTestPre()
    got = darts(x, y)

    assertEquals(got, want)
    _debugTestPost()
}

function casesDarts() {
    printf "Running %d test cases\n\n", length(cases)
    caseNum = 0

    # Associative arrays don't preserve insert order.
    for (key in cases) {
        input = key
        want = cases[key]

        _ = split(input, a, " ")
        x = a[1]
        y = a[2]

        _debugTestPre()
        got = darts(x, y)

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
    testDarts_inner()
    testDarts_middle()
    testDarts_outer()
    testDarts_outside()

    test_hypot()

    # running tests with reduced duplication
    casesDarts()

    print "\n" passed " out of " testCount " tests passed!"

    # add exit here to keep it from looping
    exit 0
}
