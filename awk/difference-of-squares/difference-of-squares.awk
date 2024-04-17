#!/usr/bin/gawk -M --lint --file

function squareOfSum(number) {
    return (number * (number + 1) / 2) ^ 2
}

function sumOfSquares(number) {
    return (number * (number + 1) * (2 * number + 1)) / 6
}

function differenceOfSquares(number) {
    return squareOfSum(number) - sumOfSquares(number)
}

BEGIN {
}

{
    if (match($0, /^difference,/)) {
        _ = split($0, part, ",")

        print differenceOfSquares(part[2])

        exit 0
    }

    if (match($0, /^square_of_sum,/)) {
        _ = split($0, part, ",")

        print squareOfSum(part[2])

        exit 0
    }

    if (match($0, /^sum_of_squares,/)) {
        _ = split($0, part, ",")

        print sumOfSquares(part[2])

        exit 0
    }

    print "error"
}

END {
}
