source "resistor-color-duo.tcl"

namespace eval ::resistorColor {

    # What:
    # 330 -> 33 ohms
    # 331 -> 330 ohms
    # 332 -> 3300 ohms
    # 333 -> 33 kiloohms
    proc label {args} {
        set colorName1 [lindex $args 0]
        set colorName2 [lindex $args 1]
        set colorName3 [lindex $args 2]
        set zeros ""
        set units "ohms"

        set colorValue [resistorColorDuo::colorValue $colorName1 $colorName2]
        set magnitude [resistorColorDuo::colorCode $colorName3]

        if { [resistorColorDuo::colorCode $colorName2] == 0 } {
            set offset 0
            if { $magnitude > 0 } {
                set offset 1
            }

            set magnitude [expr $magnitude + $offset]
            set colorValue [resistorColorDuo::colorCode $colorName1]
        }

        if { $magnitude < 3 } {
            set zeros [string repeat "0" $magnitude]
        } elseif { $magnitude == 3 } {
            set units "kilo$units"
        } elseif { $magnitude == 4 } {
            set units "kilo$units"
            set zeros [string repeat "0" 1]
        } elseif { $magnitude == 5 } {
            set units "kilo$units"
            set zeros [string repeat "0" 2]
        } elseif { $magnitude == 6 } {
            set units "mega$units"
        } elseif { $magnitude == 7 } {
            set units "kilo$units"
            set zeros [string repeat "0" 1]
        } elseif { $magnitude == 8 } {
            set units "kilo$units"
            set zeros [string repeat "0" 2]
        } elseif { $magnitude == 9 } {
            set units "giga$units"
        } else {
            set zeros [string repeat "0" $magnitude]
        }

        # puts "rawValue: $colorValue 10^$magnitude"

        return "$colorValue$zeros $units"
    }
}
