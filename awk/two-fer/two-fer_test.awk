#!/usr/bin/awk --lint --file

@include "awkunit"
@include "two-fer"

passed = 0

function testTwoFer_default() {
    want = "One for you, one for me."
    got = twoFer("")
    assertEquals(want, got)
	passed = passed + 1
}

function testTwoFer_one() {
    want = "One for Alice, one for me."
    got = twoFer("Alice")
    assertEquals(want, got)
	passed = passed + 1
}

function testTwoFer_two() {
    want = "One for Mary Ann, one for me."
    got = twoFer("Mary Ann")
    assertEquals(want, got)
	passed = passed + 1
}

BEGIN {
    testTwoFer_default()
    testTwoFer_one()
    testTwoFer_two()

	cmd = "grep --no-filename --count ^function\\ test *_test.awk"
	cmd | getline testCount

	print "\n" passed " out of " testCount " tests passed!" > "/dev/stderr"
    exit 0
}
