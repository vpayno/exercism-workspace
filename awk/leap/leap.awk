#!/usr/bin/gawk --lint --file

function leap(year) {
    if (length(year) == 0) {
        return "error: you forgot to tell me the year"
    }

    if (year == 0) {
        return "error: there's no year zero"
    }

    if (year < 0) {
        return "error: do BC years have leap years?"
    }

    if (year % 400 == 0) {
        return "true"
    }

    if (year % 100 == 0) {
        return "false"
    }

    if (year % 4 == 0) {
        return "true"
    }

    return "false"
}

BEGIN {
}

{
    if (! match($0, /^[1-9][0-9]*$/)) {
        print "error: invalid year [" year "], the only supported years are >=1"
        exit 1
    }

    print leap($0)
}

END {
}
