#!/usr/bin/gawk --bignum --lint --file

@load "ordchr"

# These variables are initialized on the command line (using '-v'):
# - ibase -> uint
# - obase -> uint

function to_base_10(input_base, input_digits) {
    base_ten = 0

    _ = split(input_digits, digits, " ")

    for (i in digits) {
        # print "digit: [" digits[i] "]"

        base_ten *= input_base
        base_ten += digits[i]
    }

    # print "base_ten: [" base_ten "]"

    return base_ten
}

function from_base_10(output_base, number) {
    output_digits = ""

    # if number isn't an int here, it will keep aproaching zero for more than a few iterations
    while (number > 0) {
        # print "number: [" number "]"

        tmp = number % output_base
        tmp = int(tmp)

        if (output_digits == "") {
            output_digits = tmp
        } else {
            output_digits = tmp " " output_digits
        }

        number /= output_base
        number = int(number)
    }

    return output_digits
}

function allYourBase(input_base, output_base, input_digits) {
    # print "ibase: [" input_base "]"
    # print "obase: [" output_base "]"
    # print "input_digits: [" input_digits "]"

    if (int(input_base) <= 1) {
        return "error:input base, " input_base ", is less than or equal to 1"
    }

    if (int(output_base) <= 1) {
        return "error:output base, " output_base ", is less than or equal to 1"
    }

    if (length(input_digits) == 0) {
        # return "error:input digits list is empty"
        # the test expects no output
        return ""
    }

    _ = split(input_digits, digits, " ")

    for (i in digits) {
        if (int(digits[i]) >= int(input_base)) {
            return "error:found input digit, " digits[i] ", that is larger than input base, " input_base
        }

        if (int(digits[i]) < 0) {
            return "error:found negative input digit, " digits[i]
        }
    }

    return from_base_10(output_base, to_base_10(input_base, input_digits))
}

BEGIN {
}

{
    # let's make sure ibase isn't being used to inject code
    if (! match(ibase, /^([0-9]+)$/)) {
        print "error: invalid input base [" ibase "], expecting unsigned integer" #> /dev/stderr
        exit 1
    }

    # let's make sure obase isn't being used to inject code
    if (! match(obase, /^([0-9]+)$/)) {
        print "error: invalid output base [" obase "], expecting unsigned integer" #> /dev/stderr
        exit 1
    }

    result = allYourBase(ibase, obase, $0)

    if (match(result, /^error:/)) {
        _ = split(result, parts, ":")
        level = parts[1]
        message = parts[2]

        print "[" level "]: " message #> /dev/stderr
        exit 1
    }

    print result
}

END {
}
