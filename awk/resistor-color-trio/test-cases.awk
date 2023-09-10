#!/usr/bin/gawk --lint --file
# test-cases.awk

#   key: input
# value: output

BEGIN {
    cases["black black black"]="0 ohms"
    cases["black grey black"]="8 ohms"
    cases["orange orange black"]="33 ohms"
    cases["blue grey brown"]="680 ohms"
    cases["brown red red"]="1200 ohms"

    cases["red black red"]="2 kiloohms"
    cases["orange orange orange"]="33 kiloohms"
    cases["green brown orange"]="51 kiloohms"
    cases["yellow violet yellow"]="470 kiloohms"
    cases["blue green yellow orange"]="650 kiloohms"

    cases["blue violet blue"]="67 megaohms"

    cases["white white white"]="99 gigaohms"

    cases["foo white white"]="error:invalid color"
    cases["white bar white"]="error:invalid color"
    cases["white white baz"]="error:invalid color"

    # add exit here to keep it from waiting for input
    exit 0
}
