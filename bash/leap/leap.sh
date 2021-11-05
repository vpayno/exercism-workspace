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
# This syntax let's us run it like this: DEBUG=true bash ./atbash_cipher.sh encode "message"
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
    local year="${1}"

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # Two arguments?
    if [[ ${#vargs[@]} -ne 1 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # First argument: Either encode or decode?
    elif [[ ! ${year} =~ ^[0-9]{4}$ ]]; then
        eprintf "ERROR: the year must be a 4-digit integer [%d].\n" "${year}"
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
    printf "Usage: %s <year>" "$0"
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: checks if a year is a leap year
# Input : 4-digit year
# Output: true if it's a leap year and false if it isn't
# Return: 0 if it's a leap year and false if it isn't
is_leap_year()
{
    local -i year="${1}"
    local result="false"

    # Is the year divisible by 4? -> leap year
    if [[ $(( year % 4 )) -eq 0 ]]; then

        result="true"

        # Is the year divisible by 100? -> not a leap year unless...
        if [[ $(( year % 100 )) -eq 0 ]]; then

            result="false"

            # Is the year divisible by 400? -> leap year
            if [[ $(( year % 400 )) -eq 0 ]]; then
                result="true"
            fi
        fi
    fi

    # Return true or false.
    printf "%s" "${result}"

    # true returns 0 and false returns 1
    # shellcheck disable=SC2046
    return $(${result})
} # is_leap_year()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local year="${1}"

    local leap_year="false"

    leap_year="$(is_leap_year "${year}")"

    eprintf "Input Year  : [%s]\n" "${year}"
    eprintf "Is Leap Year: [%s]\n" "${leap_year}"
    ${DEBUG} || printf "%s\n" "${leap_year}"
} # main()

# Run the main function.
main "${@}"
