namespace eval resistorColor {

    # What: Look up the numerical value associated with a particular color band.
    proc colorCode {color} {
        set index [lsearch -exact [colors] $color]

        if {$index < 0} {
            error "Invalid color: $color"
        } else {
            return $index
        }
    }

    # What: List the different band colors.
    # Why : Use the list to get the index value of the color.
    proc colors {args} {
        return [list "black" "brown" "red" "orange" "yellow" "green" "blue" "violet" "grey" "white"]
    }
}
