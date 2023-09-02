#!/usr/bin/gawk --lint --file
# test-cases.awk

#   key: input
# value: output

BEGIN {
    cases["Alice"]="One for Alice, one for me."
    cases["Bohdan"]="One for Bohdan, one for me."
    cases[""]="One for you, one for me." # wow, this works
    cases["Zaphod"]="One for Zaphod, one for me."

    cases["Mary Ann"]="One for Mary Ann, one for me."

    # add exit here to keep it from waiting for input
    exit 0
}
