#!/usr/bin/awk --lint --file

@include "awkunit"
@include "test-cases"
@include "reverse-string"

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

function testReverseString_zero() {
	input = ""
    want = ""

	_debugTestPre()
    got = reverseString(input)

    assertEquals(want, got)
	_debugTestPost()
}

function testReverseString_one() {
	input = "12345"
    want = "54321"

	_debugTestPre()
    got = reverseString(input)

    assertEquals(want, got)
	_debugTestPost()
}

function testReverseString_two() {
	input = "01234 56789"
    want = "98765 43210"

	_debugTestPre()
    got = reverseString(input)

    assertEquals(want, got)
	_debugTestPost()
}

function casesReverseString() {
	printf "Running %d test cases\n\n", length(cases)
	caseNum = 0

	# Associative arrays don't preserve insert order.
	for (key in cases) {
		input = key
		want = cases[key]

		_debugTestPre()
		got = reverseString(input)

		assertEquals(want, got)
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

    testReverseString_zero()
    testReverseString_one()
    testReverseString_two()

	casesReverseString()

	print "\n" passed " out of " testCount " tests passed!"

	# add exit here to keep it from looping
    exit 0
}
