proc beerSong {start take} {
    set song [verses $start [expr { $start - $take + 1 }]]

    set song [string trimright $song "\n"]

    return $song
}

proc verses { start stop } {
    set lines ""

    for { set i $start } { $i >= $stop } { incr i -1 } {
        append lines [verse $i]
    }

    return $lines
}

proc verse { beerCount } {
    set plural ""
    set beerWord ""
    set countWord "one"

    if { $beerCount == 0 } {
        set line1 "No more bottles of beer on the wall, no more bottles of beer.\n"
        set line2 "Go to the store and buy some more, 99 bottles of beer on the wall.\n"

        return "$line1$line2"
    }

    if { $beerCount > 1 } {
        set plural "s"
    }

    set line1 "$beerCount bottle$plural of beer on the wall, $beerCount bottle$plural of beer.\n"

    set beerCount [expr { $beerCount - 1 }]

    if { $beerCount == 0 || $beerCount > 1 } {
        set plural "s"
    } else {
        set plural ""
    }

    set beerWord $beerCount

    if { $beerCount == 0 } {
        set beerWord "no more"
        set countWord "it"
        set plural "s"
    }

    set line2 "Take $countWord down and pass it around, $beerWord bottle$plural of beer on the wall.\n"

    return "$line1$line2"
}
