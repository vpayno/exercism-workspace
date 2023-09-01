#!/usr/bin/gawk --lint --file

function hypot(x_2, y_2) {
    # d=√( (x_2-x_1)²+(y_2-y_1)² )
    return sqrt((x_2*x_2) + (y_2*y_2))
}

function darts(x, y) {
    distance = hypot(x, y)

    if (distance <= 1.0) {
        return 10
    }

    if (distance <= 5.0) {
        return 5
    }

    if (distance <= 10.0) {
        return 1
    }

    return 0
}

BEGIN {
}

{
    print darts($1, $2)
}

END {
}
