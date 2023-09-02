#!/usr/bin/gawk --lint --file

function reverse_string(forward) {
    reversed = ""

    split(forward, chars, "")

    for (i = 1; i <= length(chars); i++) {
        reversed = chars[i] reversed
    }

    return reversed
}

function is_valid(input) {
    if (length(input) <= 1) {
        return "false"
    }

    if (match(input, /^[ 0-9]+$/)) {
        return "true"
    }

    return "false"
}

function luhn(input) {
    if(is_valid(input) == "false") {
        return "false"
    }

    _ = gsub(/ /, "", input)

    if (input == 0 && length(input) == 1) {
        return "false"
    }

    _ = split(reverse_string(input), numbers, "")

    for (i = 1; i <= length(input); i++) {
        digit = numbers[i]

        if(i % 2 != 0) {
            continue
        }

        new_digit = digit * 2

        if(new_digit > 9) {
            new_digit -= 9
        }

        numbers[i] = new_digit
    }

    sum = 0
    for (i = 1; i <= length(input); i++) {
        digit = numbers[i]
        sum += digit
    }

    if (sum % 10 == 0) {
        return "true"
    }

    return "false"
}

BEGIN {
}

{
    print luhn($0)
}

END {
}
