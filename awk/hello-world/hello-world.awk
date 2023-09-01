#!/usr/bin/gawk --lint --file

function helloWorld() {
    return "Hello, World!"
}

BEGIN {
    print helloWorld()
}
