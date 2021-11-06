#!/usr/bin/env bash
#
# Bash Reference Manual (HTML)        : https://www.gnu.org/software/bash/manual/
# Bash Reference Manual (PDF)         : https://www.gnu.org/s/bash/manual/bash.pdf
#
# Bash Guide for Beginners (HTML)     : https://tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html
# Bash Guide for Beginners (PDF)      : https://tldp.org/LDP/Bash-Beginners-Guide/Bash-Beginners-Guide.pdf
#
# Advanced Bash-Scripting Guide (HTML): https://tldp.org/LDP/abs/html/
# Advanced Bash-Scripting Guide (PDF) : https://tldp.org/LDP/abs/abs-guide.pdf

# Enable/Disable debug output.
# This syntax let's us run it like this: DEBUG=true bash ./script_name.sh parameters
: "${DEBUG:=false}"

# Protect oursevles from code injection.
if [[ ! ${DEBUG,,} =~ ^(false|true)$ ]]; then
    DEBUG="false"
fi

# Lowercase the string and add /bin/ to the start of the string.
DEBUG="/bin/${DEBUG,,}"

# Function: printf to stderr if DEBUG is set to true
# Input : same as printf
# Output: same as printf, except it goes to stderr instead of stdout
# Return: from printf
eprintf()
{
    # Pass all the printf arguments and redirect stdout to stderr.
    # shellcheck disable=SC2059
    ${DEBUG} && printf "$@" >&2
} # eprintf()

# Function: check the validity of the script's arguments.
# Input : script arguments
# Output: error messages
# Return: 0 (valid) or >=1 (one or more input problems found)
check_args()
{
    # Capture the script's arguments.
    local -a vargs=( "$@" )
    local arg1="${1}"
    local arg2="${2}"

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # Two arguments?
    if [[ ${#vargs[@]} -ne 2 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # Arguments: rational numbers?
    elif [[ ! ${arg1} =~ ^-?[0-9]+[.]?[0-9]*$ ]] || [[ ! ${arg2} =~ ^-?[0-9]+[.]?[0-9]*$ ]]; then
        eprintf "ERROR: arguments [(%s, %s)] can either be positive or negative integer or float.\n" "${arg1}" "${arg2}"
        show_usage
        (( retval++ ))
    fi

    # If a non-zero value is returned, it means that one or more tests have failed.
    return "${retval}"
} # check_args()

# Function: print the scripts usage help message.
# Input : none
# Output: usage help screen
# Return: 1 (always)
show_usage()
{
    printf "Usage: %s \"<string>\"" "$0"
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: returns the score for the dart throw
# Input : (x, y) coordinates
# Output: 0, 1, 5, 10
# Return: 0
get_dart_score()
{
    # Don't use Bash integers for the coordinates.
    local x="${1}"
    local y="${2}"

    local -i score

    # This is used as a float and a string.
    local radius

    # Figure out where the dart landed using it's (x, y) coordinate.
    # r^2 = (x – h)^2 + (y – k)^2
    radius="$(bc <<< "scale=4; r=sqrt( (${x} - 0)^2 + (${y} - 0)^2 ); r")"
    eprintf "Radius (float): %0.2f\n" "${radius}"

    if [[ $(bc <<< "${radius} <= 1") -eq 1 ]]; then
        # On or within the innter cicle with radius of 1
        score="10"
    elif [[ $(bc <<< "${radius} <= 5") -eq 1 ]]; then
        # On or within the middle cicle with radius of 5
        score="5"
    elif [[ $(bc <<< "${radius} <= 10") -eq 1 ]]; then
        # On or within the outer cicle with radius of 10
        score="1"
    else
        # out of bounds
        score=0
    fi

    printf "%s" "${score}"
} # get_dart_score()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local x="${1}"
    local y="${2}"

    local -i score

    score="$(get_dart_score "${x}" "${y}")"

    eprintf "\n"
    eprintf "(x, y)     : [(%s, %s)]\n" "${x}" "${y}"
    eprintf "Score      : [%s]\n" "${score}"
    ${DEBUG} || printf "%s\n" "${score}"
} # main()

# Run the main function.
main "${@}"
