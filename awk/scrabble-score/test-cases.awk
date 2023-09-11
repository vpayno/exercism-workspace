#!/usr/bin/gawk --lint --file
# test-cases.awk

#   key: input
# value: output

BEGIN {
    cases[""]=",0" # wow, this works with a warning

    cases["a"]="A,1"
    cases["e"]="E,1"
    cases["i"]="I,1"
    cases["o"]="O,1"
    cases["u"]="U,1"
    cases["l"]="L,1"
    cases["n"]="N,1"
    cases["r"]="R,1"
    cases["s"]="S,1"
    cases["t"]="T,1"

    cases["d"]="D,2"
    cases["g"]="G,2"

    cases["b"]="B,3"
    cases["c"]="C,3"
    cases["m"]="M,3"
    cases["p"]="P,3"

    cases["f"]="F,4"
    cases["v"]="V,4"
    cases["w"]="W,4"
    cases["y"]="Y,4"

    cases["k"]="K,5"

    cases["j"]="J,8"
    cases["x"]="X,8"

    cases["q"]="Q,10"
    cases["z"]="Z,10"

    cases["abcdefghijklmnopqrstuvwxyz"]="ABCDEFGHIJKLMNOPQRSTUVWXYZ,87"
    cases["abcdefghijklmnop rstuvwxyz"]="ABCDEFGHIJKLMNOP RSTUVWXYZ,77"

    cases["at"]="AT,2"
    cases["zoo"]="ZOO,12"
    cases["street"]="STREET,6"
    cases["quirky"]="QUIRKY,22"
    cases["OxyphenButazone"]="OXYPHENBUTAZONE,41"
    cases["pinata"]="PINATA,8"

    # add exit here to keep it from waiting for input
    exit 0
}
