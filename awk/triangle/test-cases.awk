#!/usr/bin/gawk --lint --file
# test-cases.awk

#   key: input
# value: output

BEGIN {
    equilateral_cases["2 2 2"]="true"
    equilateral_cases["0.5 0.5 0.5"]="true"

    equilateral_cases["0 0 0"]="false"
    equilateral_cases["2 3 2"]="false"
    equilateral_cases["5 4 6"]="false"

    isosceles_cases["3 4 4"]="true"
    isosceles_cases["4 4 3"]="true"
    isosceles_cases["4 3 4"]="true"
    isosceles_cases["4 4 4"]="true"
    isosceles_cases["0.5 0.4 0.5"]="true"

    isosceles_cases["2 3 4"]="false"
    isosceles_cases["1 1 3"]="false"
    isosceles_cases["1 3 1"]="false"
    isosceles_cases["3 1 1"]="false"
    isosceles_cases["1.5 2.5 1.0"]="false"

    scalene_cases["5 4 6"]="true"
    scalene_cases["0.5 0.4 0.6"]="true"

    scalene_cases["4 4 4"]="false"
    scalene_cases["4 4 3"]="false"
    scalene_cases["3 4 3"]="false"
    scalene_cases["4 3 3"]="false"
    scalene_cases["7 3 2"]="false"

    # add exit here to keep it from waiting for input
    exit 0
}
