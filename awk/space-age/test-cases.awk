#!/usr/bin/gawk --lint --file
# test-cases.awk

#   key: input
# value: output

BEGIN {
    cases[""]="error:no planet or seconds given"

    cases["Mercury 2134835688"]="280.88"
    cases["Venus 189839836"]="9.78"
    cases["Earth 1000000000"]="31.69"
    cases["Mars 2129871239"]="35.88"
    cases["Jupiter 901876382"]="2.41"
    cases["Saturn 2000000000"]="2.15"
    cases["Uranus 1210123456"]="0.46"
    cases["Neptune 1821023456"]="0.35"

    cases["Sun 680804807"]="error:not a planet"

    # add exit here to keep it from waiting for input
    exit 0
}
