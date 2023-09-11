#!/usr/bin/gawk --bignum --lint --file

function etl(input) {
    uppercase = ""
    score = 0

    if (length(input) == 0) {
        return uppercase "," score
    }

    _ = split(input, chars, "")

    for (i=1; i<=length(input); ++i) {
        letter = toupper(chars[i])

        # intentionally using strings with fallthrough cases and single regex cases
        switch(letter) {
            case /^[AEIOULNRST]$/:
                score += 1
                break
            case "D":
            case "G":
                score += 2
                break
            case /^[BCMP]$/:
                score += 3
                break
            case /^[FHVWY]$/:
                score += 4
                break
            case "K":
                score += 5
                break
            case /^[JX]$/:
                score += 8
                break
            case /^[QZ]$/:
                score += 10
                break
            default:
                break
        }

        uppercase = uppercase letter
    }

    return uppercase "," score
}

BEGIN {
}

{
    print etl($0)
}

END {
}
