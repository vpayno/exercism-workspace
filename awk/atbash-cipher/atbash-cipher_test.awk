#!/usr/bin/gawk --lint --file

@include "awkunit"
@include "test-cases"
@include "atbash-cipher"

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

function test_shift_letter_encode() {
    input = "a"
    want = "z"

    _debugTestPre()
    got = shift_letter(input)

    assertEquals(got, want)
    _debugTestPost()
}

function test_shift_letter_decode() {
    input = "z"
    want = "a"

    _debugTestPre()
    got = shift_letter(input)

    assertEquals(got, want)
    _debugTestPost()
}

function testAtbashCipher_encode() {
    input = "abcdefghijklmnopqrstuvwxyz"
    want = "zyxwv utsrq ponml kjihg fedcb a"

    # _ = split(input, a, " ")

    direction = "encode"

    _debugTestPre()
    got = atbash_cipher(input)

    assertEquals(got, want)
    _debugTestPost()
}

function testAtbashCipher_decode() {
    input = "zyxwvutsrqponmlkjihgfedcba"
    want = "abcdefghijklmnopqrstuvwxyz"

    # _ = split(input, a, " ")

    direction = "decode"

    _debugTestPre()
    got = atbash_cipher(input)

    assertEquals(got, want)
    _debugTestPost()
}

function casesAtbashCipher_encode() {
    printf "Running %d test cases\n\n", length(encode_cases)
    caseNum = 0

    direction = "encode"

    # Associative arrays don't preserve insert order.
    for (key in encode_cases) {
        input = key
        want = encode_cases[key]

        # _ = split(input, a, " ")

        _debugTestPre()
        got = atbash_cipher(input)

        assertEquals(got, want)
        _debugTestPost()
    }
}

function casesAtbashCipher_decode() {
    printf "Running %d test cases\n\n", length(decode_cases)
    caseNum = 0

    direction = "decode"

    # Associative arrays don't preserve insert order.
    for (key in decode_cases) {
        input = key
        want = decode_cases[key]

        # _ = split(input, a, " ")

        _debugTestPre()
        got = atbash_cipher(input)

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

    testCount = testCount + length(encode_cases) + length(decode_cases)

    test_shift_letter_encode()
    test_shift_letter_decode()

    # running tests with a lot of duplication
    testAtbashCipher_encode()
    testAtbashCipher_decode()

    # running tests with reduced duplication
    casesAtbashCipher_encode()
    casesAtbashCipher_decode()

    print "\n" passed " out of " testCount " tests passed!"

    # add exit here to keep it from looping
    exit 0
}
