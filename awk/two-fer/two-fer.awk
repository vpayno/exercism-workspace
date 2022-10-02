#!/usr/bin/env awk --lint

function twoFer(name) {
	if (length(name) == 0) {
		name = "you"
	}

	return "One for " name ", one for me."
}

BEGIN {
	input = ""
}

END {
	if (length($0) > 0) {
		input = $0
	}

	print twoFer(input)
}
