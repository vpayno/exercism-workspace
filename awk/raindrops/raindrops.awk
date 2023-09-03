#!/usr/bin/gawk --lint --file

# These variables are initialized on the command line (using '-v'):
# - num -> ^([0-9]+$

function raindrops(number) {
    sounds = ""

    if (length(number) == 0) {
        return "error: nothing has no sound"
    }

    if (number == 0) {
        return number
    }

    if (number % 3 == 0) {
        sounds = sounds "Pling"
    }

    if (number % 5 == 0) {
        sounds = sounds "Plang"
    }

    if (number % 7 == 0) {
        sounds = sounds "Plong"
    }

    if (length(sounds) == 0) {
        sounds = number
    }

    return sounds
}

BEGIN {
    # let's make sure num isn't being used to inject code
    if (! match(num, /^[0-9]+$/)) {
        print "error: invalid number [" num "], the only supported numbers are ^[0-9]+$"
        exit 1
    }

    print raindrops(num)

    exit 0
}

{
    # using this section got us stuck waiting for input that is only given via variables
}

END {
}
