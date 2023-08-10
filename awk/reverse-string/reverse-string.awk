#!/usr/bin/awk --lint --file

function reverseString(forward) {
    reversed = ""

    split(forward, chars, "")

    for (i = 1; i <= length(chars); i++) {
        reversed = chars[i] reversed
    }

    return reversed
}

BEGIN {
    input = ""
}

{
    if (length($0) > 0) {
        input = $0
    }

    print reverseString(input)

    # add exit here to keep it from looping
    exit 0
}
