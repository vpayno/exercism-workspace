#!/usr/bin/gawk --lint --file

# These variables are initialized on the command line (using '-v'):
# - num -> /^[0-9]+$/

function log10(n) {
    return int(log(n)/log(10))
}

function armstrong_numbers(candidate) {
    if (candidate < 10) {
        return "true"
    }

    digit_count = log10(candidate) + 1
    number = candidate
    pow_total = 0

    while (number > 0) {
        pow_temp = int(number % 10)
        #pow_temp_total = 1

        #for (i = 0; i < digit_count; i++) {
            #pow_temp_total = int(pow_temp_total * pow_temp)
        #}

        #pow_total += pow_temp_total
        #number = int(number / 10)

        pow_total += int(pow_temp ^ digit_count)
        number = (number - pow_temp) / 10
    }

    if (pow_total == candidate) {
        return "true"
    }

    return "false"
}

BEGIN {
    # make sure num doesn't inject code
    if (! match(num, /^[0-9]+$/)) {
        print "error: invalid number [" num "]" > "/dev/stderr"
        exit 1
    }

    print armstrong_numbers(num)

    exit 0
}

{
}

END {
}
