#!/usr/bin/gawk --bignum --lint --file

function is_planet(color) {
    return match(color, /^(Mercury|Venus|Earth|Mars|Jupiter|Saturn|Uranus|Neptune)?$/)
}

function spaceAge(input) {
    if (input == "") {
        return "error:no planet or seconds given"
    }

    SECONDS_IN_EARTH_YEARS = 365.25 * 24 * 60 * 60

    planets["Mercury"]=0.2408467
    planets["Venus"]=0.61519726
    planets["Earth"]=1.0
    planets["Mars"]=1.8808158
    planets["Jupiter"]=11.862615
    planets["Saturn"]=29.447498
    planets["Uranus"]=84.016846
    planets["Neptune"]=164.79132

    # already tested that we have a correct input, we don't need to check that
    # we got 3 numbers.
    _ = split(input, data, " ")

    planet = data[1]

    if (!is_planet(planet)) {
        return "error:not a planet"
    }

    seconds = data[2]

    if (seconds <= 0) {
        return "error:seconds not valid"
    }

    return sprintf("%.2f", seconds / (planets[planet] * SECONDS_IN_EARTH_YEARS))
}

BEGIN {
}

{
    result = spaceAge($0)

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
