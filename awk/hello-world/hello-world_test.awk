#!/usr/bin/awk --lint --file

@include "awkunit"
@include "hello-world"

function testHelloWorld() {
    want = "Hello, World!"
    got = helloWorld()
    assertEquals(want, got)
}

BEGIN {
    testHelloWorld()
    exit 0
}
