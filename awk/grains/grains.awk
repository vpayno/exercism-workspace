#!/usr/bin/gawk -M --lint --file

function total() {
    return 2^64 -1
}

function grains(square) {
    if (square == "total") {
        return total()
    }

    if (square < 1 || square > 64) {
        return "error:square must be between 1 and 64"
    }

    return lshift(1, square-1)
}

BEGIN {
}

{
    if (match($0, /^total$/)) {
        print total()

        exit 0
    }

    result = grains($0)

    if (match(result, /^error:/)) {
        _ = split(result, part, ":")
        print part[2]
        exit 1
    }

    print result
}

END {
}
