#!/usr/bin/gawk --bignum --lint --file

function is_color(color) {
    return match(color, /^(black|brown|red|orange|yellow|green|blue|violet|grey|white)?$/)
}

function resistorColorDuo(input) {
    e = 0
    resistor_band["black"]=e++
    resistor_band["brown"]=e++
    resistor_band["red"]=e++
    resistor_band["orange"]=e++
    resistor_band["yellow"]=e++
    resistor_band["green"]=e++
    resistor_band["blue"]=e++
    resistor_band["violet"]=e++
    resistor_band["grey"]=e++
    resistor_band["white"]=e++
    resistor_band["count"]=e

    e = 0
    resistor_band[e++]="black"
    resistor_band[e++]="brown"
    resistor_band[e++]="red"
    resistor_band[e++]="orange"
    resistor_band[e++]="yellow"
    resistor_band[e++]="green"
    resistor_band[e++]="blue"
    resistor_band[e++]="violet"
    resistor_band[e++]="grey"
    resistor_band[e++]="white"
    resistor_band[e]="count"

    # already tested that we have a correct input, we don't need to check that
    # we got 3 numbers.
    _ = split(input, colors, " ")

    if (!is_color(colors[1])) {
        return "error:invalid color"
    }

    resistor_value = resistor_band[colors[1]] * 10

    if (!is_color(colors[2])) {
        return "error:invalid color"
    }

    resistor_value += resistor_band[colors[2]]

    return resistor_value
}

BEGIN {
}

{
    # let's make sure direction isn't being used to inject code
    if (NF < 2) {
        result = "error: invalid color" # should be invalid number of colors/bands
    } else {
        result = resistorColorDuo($0)
    }

    if (match(result, /^error:/)) {
        _ = split(result, parts, ":")
        level = parts[1]
        message = parts[2]

        print "[" level "]: " message #> "/dev/stderr"
        exit 1
    }

    print result
}

END {
}
