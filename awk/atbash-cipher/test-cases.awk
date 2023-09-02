#!/usr/bin/gawk --lint --file
# test-cases.awk

#   key: input
# value: output

BEGIN {
    encode_cases[""]="" # wow, this works with a warning
    encode_cases["abcdefghijklmnopqrstuvwxyz"]="zyxwv utsrq ponml kjihg fedcb a"
    encode_cases["test"]="gvhg"
    encode_cases["x123 yes"]="c123b vh"

    encode_cases["yes"]="bvh"
    encode_cases["no"]="ml"
    encode_cases["OMG"]="lnt"
    encode_cases["O M G"]="lnt"
    encode_cases["mindblowingly"]="nrmwy oldrm tob"
    encode_cases["Testing,1 2 3, testing."]="gvhgr mt123 gvhgr mt"
    encode_cases["Truth is fiction."]="gifgs rhurx grlm"
    encode_cases["The quick brown fox jumps over the lazy dog"]="gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"

    decode_cases[""]="" # wow, this works with a warning
    decode_cases["zyxwvutsrqponmlkjihgfedcba"]="abcdefghijklmnopqrstuvwxyz"
    decode_cases["gvhg"]="test"
    decode_cases["c123b vh"]="x123yes"

    decode_cases["vcvix rhn"]="exercism"
    decode_cases["zmlyh gzxov rhlug vmzhg vkkrm thglm v"]="anobstacleisoftenasteppingstone"
    decode_cases["gvhgr mt123 gvhgr mt"]="testing123testing"
    decode_cases["gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"]="thequickbrownfoxjumpsoverthelazydog"
    decode_cases["vc vix    r hn"]="exercism"
    decode_cases["zmlyhgzxovrhlugvmzhgvkkrmthglmv"]="anobstacleisoftenasteppingstone"

    # add exit here to keep it from waiting for input
    exit 0
}
