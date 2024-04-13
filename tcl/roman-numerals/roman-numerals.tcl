proc toroman {number} {
    set d2r [dict create 1 "I" 4 "IV" 5 "V" 9 "IX" 10 "X" 40 "XL" 50 "L" 90 "XC" 100 "C" 400 "CD" 500 "D" 900 "CM" 1000 "M"]

    set roman ""

    foreach key [lreverse [dict keys $d2r]] {
        set letter [dict get $d2r $key]

        while {$number >= $key} {
            append roman $letter

            # tcl treats everything as a string, using scan didn't work to create a string
            # expect variable 'digits' as 'numeric' but is 'string'
            scan $key %d digits

            set number [expr {$number - $digits}]
        }
    }

    return $roman
}
