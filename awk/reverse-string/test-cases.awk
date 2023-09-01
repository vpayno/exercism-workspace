#!/usr/bin/gawk --lint --file
# test-cases.awk

#   key: input
# value: output

BEGIN {
    cases[""]="" # wow, this works
    cases["robot"]="tobor"
    cases["Ramen"]="nemaR"
    cases["I'm hungry!"]="!yrgnuh m'I"
    cases["racecar"]="racecar"
    cases["drawer"]="reward"

    # add exit here to keep it from waiting for input
    exit 0
}
