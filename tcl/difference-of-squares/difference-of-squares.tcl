proc squareOfSum {number} {
    return [expr ($number * ($number + 1) / 2) ** 2]
}

proc sumOfSquares {number} {
    return [expr ($number * ($number + 1) * (2 * $number + 1) / 6)]
}

proc differenceOfSquares {number} {
    set square [squareOfSum $number]
    set sum [sumOfSquares $number]

    return [expr {$square - $sum}]
}
