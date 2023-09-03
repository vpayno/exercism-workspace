#!/usr/bin/gawk --bignum --lint --file

@load "ordchr"

# These variables are initialized on the command line (using '-v'):
# - type -> ^(equilateral|isosceles|scalene)$

function is_triangle(s) {
    a = s[1]
    b = s[2]
    c = s[3]

    # true if
    # - all sides are >0
    # - the sum of any two sides is greater than or equal to the other side
    return (a > 0) && (b > 0) && (c > 0) && (a + b >= c) && (a + c >= b) && (b + c >= a)
}

function is_equilateral(s) {
    a = s[1]
    b = s[2]
    c = s[3]

    # true if all sides are equal
    return (a == b) && (a == c)
}

function is_isosceles(s) {
    a = s[1]
    b = s[2]
    c = s[3]

    # true if any two sides are equal
    # every equilateral triangle is also an isosceles triangle
    return (a == b) || (b == c) || (a == c)
}

function is_scalene(s) {
    a = s[1]
    b = s[2]
    c = s[3]

    # true of no side is equal to another side
    return (a != b) && (a != c) && (b != c)
}

function to_faux_bool(condition) {
    # converts >=1 to true and 0 to false
    return condition ? "true" : "false"
}

function triangle(input) {
    result = "false"

    if (!match(input, /^[0-9]+[.]?[0-9]* [0-9]+[.]?[0-9]* [0-9]+[.]?[0-9]*$/)) {
        return "error:invalid data [" input "], expected 3 space separated positive numbers"
    }

    # already tested that we have a correct input, we don't need to check that
    # we got 3 numbers.
    _ = split(input, sides, " ")

    if (!is_triangle(sides)) {
        # the tests don't care if the triangles are valid,
        # that error is mixed in with the type tests
        # return "error:not a triangle [" input "]"
        return "false"
    }

    switch (type) {
        case "equilateral":
            result = to_faux_bool(is_equilateral(sides))
            break
        case "isosceles":
            result = to_faux_bool(is_isosceles(sides))
            break
        case "scalene":
            result = to_faux_bool(is_scalene(sides))
            break
    }

    return result
}

BEGIN {
}

{
    # let's make sure direction isn't being used to inject code
    if (! match(type, /^(equilateral|isosceles|scalene)$/)) {
        print "error: invalid type [" type "], only supported types are ^(equilateral|isosceles|scalene)$" #> /dev/stderr
        exit 1
    }

    result = triangle($0)

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
