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

    # Does the string contain a valid 10-digit phone number?
    elif [[ ! ${input} =~ ^[^0-9]*1?[^0-9]*[2-9][0-9]{2}[^0-9]*[2-9][0-9]{2}[^0-9]*[0-9]{4}[^0-9]*$ ]]; then
        eprintf "ERROR: input [%s] doesn't contain a valid phone number.\n" "${input}"
        #show_usage
        printf "%s\n" "Invalid number.  [1]NXX-NXX-XXXX N=2-9, X=0-9"
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
        printf "%s\n\n" "Clean up user-entered phone numbers so that they can be sent SMS messages."
        printf "Usage: %s \"1-321-654-0987\"" "$0"
        printf "\n"
    } >&2
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: trim whitespace at the end of the string.
# Input : string
# Output: string with no leading or traling whitespace
# Return: 0 (trimmed) or 1 (not trimmed)
trim()
{
    local line="${1}"

    # remove traling whitespace
    line="${line#"${line%%[![:space:]]*}"}"

    # remove leading whitespace
    line="${line%"${line##*[![:space:]]}"}"

    printf "%s" "${line}"
} # trim()

# Function: Extracts a 10-digit phone number from an input.
# Input : string
# Output: 10-digit phone number
# Result: 0 (success), 1 (failure)
extract_phonenumber()
{
    local input="${1}"

    local -i retval=0
    local result

    result="$(tr -d '[:alpha:][:punct:][:space:]' <<< "${input}")"

    printf "%s" "${result#1}"
    return "${retval}"
} # extract_phonenumber()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local input="${1}"

    local output

    eprintf "Input: [%s]\n" "${input}"

    input="$(trim "${input}")"

    output="$(extract_phonenumber "${input}")"

    eprintf "Output: [%s]\n" "${output}"
    ${DEBUG} || printf "%s\n" "${output}"
} # main()

# Run the main function.
main "${@}"
