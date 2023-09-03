#!/usr/bin/gawk --lint --file
# test-cases.awk

#   key: input
# value: output

BEGIN {
    cases["10"]="false"
    cases["100"]="false"
    cases["154"]="false"
    cases["9926314"]="false"

    cases["0"]="true"
    cases["5"]="true"
    cases["9"]="true"
    cases["153"]="true"
    cases["9474"]="true"
    cases["9926315"]="true"
    cases["186709961001538790100634132976990"]="true"
    cases["115132219018763992565095597973971522401"]="true"

    # add exit here to keep it from waiting for input
    exit 0
}
