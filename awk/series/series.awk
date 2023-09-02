#!/usr/bin/gawk --lint --file

function series(input) {
    arg_count = split(input, args, ":")

    if (arg_count != 2) {
        return "wrong number of arguments"
    }

    span_length = args[1]
    number_sequence = args[2]

    number_count = split(number_sequence, numbers, "")

    # could also test to make sure that length(sequence) == count
    if (number_count == 0) {
        # should be "sequence should have at least one number in it"
        return "error: series cannot be empty"
    }

    if (span_length <= 0) {
        # should be "span length needs to be greater than 0"
        return "error: invalid length"
    }

    if (span_length > length(number_sequence)) {
        # should be "span length can't be larger than sequence length"
        return "error: invalid length"
    }

    span_sequence = ""

    for (i = 1; i <= (length(input) - span_length - 1); i++) {
        span = substr(number_sequence, i, span_length)

        if (length(span_sequence) == 0) {
            span_sequence = span
        } else {
            span_sequence = span_sequence " " span
        }
    }

    return span_sequence
}

BEGIN {
}

{
    result = series(len":"$0)

    if (match(result, /^error: /)) {
        _ = split(result, part, ":")
        print part[2]
        exit 1
    }

    print result
}

END {
}
