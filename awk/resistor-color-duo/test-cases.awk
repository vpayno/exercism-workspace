#!/usr/bin/gawk --lint --file
# test-cases.awk

#   key: input
# value: output

BEGIN {
    cases["brown green"]=15
    cases["brown green violet"]=15
    cases["brown black"]=10
    cases["blue grey"]=68
    cases["yellow violet"]=47
    cases["white red"]=92
    cases["orange orange"]=33
    cases["foo"]="error:invalid color"
    cases["green brown orange"]=51
    cases["black brown"]=1
    cases["black grey"]=8

    # add exit here to keep it from waiting for input
    exit 0
}
