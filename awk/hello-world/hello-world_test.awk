#!/usr/bin/gawk --lint --file

@include "awkunit"
@include "test-cases"
@include "hello-world"

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

function casesHelloWorld() {
    printf "Running %d test cases\n\n", length(cases)
    caseNum = 0

    # Associative arrays don't preserve insert order.
    for (key in cases) {
        # function parameter data
        input = key

        # expected function return data
        want = cases[key]

        _debugTestPre()
        # got = helloWorld(input)
        got = helloWorld()

        assertEquals(want, got)
        _debugTestPost()
    }
}

# test-case less test function
function testHelloWorld() {
    want = "Hello, World!"
    got = helloWorld()
    assertEquals(want, got)
}

BEGIN {
    exit 0
}

END {
    cmd = "grep --no-filename --count ^function\\ test *_test.awk"
    cmd | getline testCount

    printf "\nRunning %d tests...\n\n", testCount

    testCount = testCount + length(cases)

    testHelloWorld()

    casesHelloWorld()

    print "\n" passed " out of " testCount " tests passed!"

    # add exit here to keep it from looping
    exit 0
}
