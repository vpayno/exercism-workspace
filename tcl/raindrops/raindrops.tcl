proc raindrops {number} {
    set sounds ""

    if { $number % 3 == 0 } {
        append sounds "Pling"
    }

    if { $number % 5 == 0 } {
        append sounds "Plang"
    }

    if { $number % 7 == 0 } {
        append sounds "Plong"
    }

    if { [string length $sounds] == 0 } {
        append sounds $number
    }

    return $sounds
}
