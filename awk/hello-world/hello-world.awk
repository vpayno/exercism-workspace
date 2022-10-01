#!/usr/bin/awk --lint --file

function helloWorld() {
	return "Hello, World!"
}

BEGIN {
	print helloWorld()
}
