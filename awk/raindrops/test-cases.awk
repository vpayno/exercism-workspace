#!/usr/bin/gawk --lint --file
# test-cases.awk

#   key: input
# value: output

BEGIN {
    cases["0"]="0"

    cases["-1"]="-1"
    cases["-3"]="Pling"
    cases["-5"]="Plang"
    cases["-7"]="Plong"

    cases["1"]="1"
    cases["8"]="8"
    cases["11"]="11"
    cases["52"]="52"

    cases["3"]="Pling"
    cases["6"]="Pling"
    cases["9"]="Pling"
    cases["12"]="Pling"

    cases["5"]="Plang"
    cases["10"]="Plang"
    cases["25"]="Plang"
    cases["3125"]="Plang"

    cases["7"]="Plong"
    cases["14"]="Plong"
    cases["28"]="Plong"
    cases["49"]="Plong"

    cases["15"]="PlingPlang"
    cases["21"]="PlingPlong"
    cases["35"]="PlangPlong"
    cases["70"]="PlangPlong"

    cases["105"]="PlingPlangPlong"
    cases["210"]="PlingPlangPlong"
    cases["945"]="PlingPlangPlong"

    # add exit here to keep it from waiting for input
    exit 0
}
