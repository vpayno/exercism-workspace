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
    local input="${1}"

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # One argument?
    if [[ ${#vargs[@]} -ne 1 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # First argument: YYYY-MM-DD || YYYY-MM-DDTHH:MM:SS
    elif [[ ! ${input} =~ ^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9](T[0-9][0-9]:[0-9][0-9]:[0-9][0-9])?$ ]]; then
        eprintf "ERROR: input date [%s] should be either YYYY-MM-DD or YYYY-MM-DDTHH:MM:SS.\n" "${input}"
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
    {
        printf "%s\n\n" "Given a moment, determine the moment that would be after a gigasecond has passed."
        printf "Usage: %s \"<UTC Date>\"" "$0"
        printf "\n"
    } >&2
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: add a gigasecond to a given date
# Input : string
# Output: string
# Return: 0
add_gigasecond()
{
    local input="${1}"
    local -n __output="${2}"

    local -i offset="1000000000"
    local -i start_date_in_seconds

    # Using date because: https://www.youtube.com/watch?v=-5wpm-gesOY

    start_date_in_seconds="$(date --utc --date "${input}" +%s)"

    __output="$(date --utc --date "@$(( start_date_in_seconds + offset ))" +%Y-%m-%dT%H:%M:%S)"
} # add_gigasecond()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local input="${1}"

    local output

    add_gigasecond "${input}" "output"

    eprintf "          Starting Date: [UTC: %s]\n" "${input}"
    eprintf "Date a Gigasecond Later: [UTC: %s]\n" "${output}"
    ${DEBUG} || printf "%s\n" "${output}"
} # main()

# Run the main function.
main "${@}"
