namespace eval ::resistorColorDuo {

    # What: convert "brownorage" to "13".
    # How: use the functions from the previous exercise here.
    proc colorValue {args} {
        set color1 [lindex $args 0]
        set color2 [lindex $args 1]

        set value1 [colorCode $color1]
        if { $value1 == 0 } {
            set value1 ""
        }
        set value2 [colorCode $color2]

        return "$value1$value2"
    }

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
