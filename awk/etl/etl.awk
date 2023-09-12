#!/usr/bin/gawk --bignum --lint --file

function etl() {
    PROCINFO["sorted_in"] = "@ind_str_asc"

    for (i=2; i<=NF; i++) {
        key = tolower($i)
        score = $1
        scores[key] = score
    }
}

# arrays keep getting passed as a scalar, using global
function prettyEtl() {
    PROCINFO["sorted_in"] = "@ind_str_asc"

    for (key in scores) {
        lines = lines key "," scores[key] "\n"
    }

    return lines
}

BEGIN {
    FPAT = "[[:alnum:]]+"
}

# score: keys
#$1  $2   $3   $4   $5   $6 -> $0
# 1: "A", "E", "I", "O", "U"
NF > 1 {
    # uses $0-9
    etl()
}

END {
    # uses scores array
    print prettyEtl()
}
