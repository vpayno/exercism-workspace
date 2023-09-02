#!/usr/bin/gawk --lint --file
# test-cases.awk

#   key: input
# value: output

BEGIN {
    cases[""]="" # wow, this works
    cases["abcdefghijklmnopqrstuvwxyz"]="zyxwvutsrqponmlkjihgfedcba"
    cases["zyxwvutsrqponmlkjihgfedcba"]="abcdefghijklmnopqrstuvwxyz"
    cases["0123456789"]="9876543210"
    cases["9876543210"]="0123456789"

    cases["cool"]="looc"

    cases["robot"]="tobor"
    cases["Ramen"]="nemaR"
    cases["I'm hungry!"]="!yrgnuh m'I"
    cases["racecar"]="racecar"
    cases["drawer"]="reward"

    # add exit here to keep it from waiting for input
    exit 0
}
