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
    local hours="${1}"
    local minutes="${2}"
    local sign="${3}"
    local delta="${4}"

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # Two arguments?
    if [[ ${#vargs[@]} -ge 2 ]] && [[ ${#vargs[@]} -le 4 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # Are the first, second and fourth arguments integers?
    elif [[ ! ${hours} =~ ^[-+]?[0-9]+$ ]]; then
        eprintf "ERROR: hours[%s] can either be postitive or negative integer.\n" "${hours}"
        show_usage
        (( retval++ ))

    elif [[ ! ${minutes} =~ ^[-+]?[0-9]+$ ]]; then
        eprintf "ERROR: minutes[%s] can either be postitive or negative integer.\n" "${minutes}"
        show_usage
        (( retval++ ))

    elif [[ ! ${delta} =~ ^[-+]?[0-9]+$ ]]; then
        eprintf "ERROR: delta[%s] can either be postitive or negative integer.\n" "${delta}"
        show_usage
        (( retval++ ))

    elif [[ ! ${sign} =~ ^(-|+)$ ]]; then
        eprintf "ERROR: sign [%s] can either be \"+\" or \"-\".\n" "${sign}"
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
    printf "Usage: %s <hours> <minutes> <+|-> <delta>" "$0"
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
#check_args "$@" || exit "$?"

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

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local input_hours="${1}"
    local input_minutes="${2}"
    local input_sign="${3}"
    local input_delta="${4}"

    local -i hours=0
    local -i minutes=0

    # Convert negative input hours to positive hours.
    if [[ ${input_hours} -lt 0 ]]; then
        hours="$(bc <<< "scale=0; x=${input_hours}; if (x % 24  == 0) { x + (24 * ((x * -1)/ 24)) } else { x + (24 * (((x * -1) / 24) + 1)) }")"
    else
        hours="${input_hours}"
    fi
    eprintf "Converting [%d] hours to [%d] hours.\n" "${input_hours}" "${hours}"

    # Convert negative input minutes to positive minutes.
    #if [[ ${input_minutes} -lt 0 ]]; then
        minutes="$(bc <<< "scale=0; x=${input_minutes}; if (x > 0) { x % 1440 } else { x % 1440 + 1440 }")"

        eprintf "Converting [%d] minutes to [%d] minutes.\n" "${input_minutes}" "${minutes}"
    #fi

    # Convert the hours to minutes.

    eprintf "Adding [%d] hours to [%d] minutes" "${hours}" "${minutes}"
    (( minutes += hours * 60 ))
    eprintf " => [%d] minutes.\n" "${minutes}"

    # Is the sign set?
    if [[ ${input_sign} =~ ^[-+]$ ]]; then
        eprintf "Adding [%s%d] minutes to [%d] minutes" "${input_sign}" "${input_delta}" "${minutes}"
        input_delta="$(bc <<< "d=( 0 ${input_sign} ${input_delta}); x=${minutes}; if (d < 0) { 60 + d } else { d }")"
        minutes="$(bc <<< "${minutes} + ${input_delta}")"
        eprintf " => [%d] minutes.\n" "${minutes}"
    fi

    hours=0

    # Get the whole hours from the sum of the minutes.
    (( hours += minutes / 60 ))
    eprintf "Converting [%d] minutes to [%d] hours.\n" "${minutes}" "${hours}"

    eprintf "Rolling over [%d] hours to [%d] hours.\n" "${hours}" "$(( hours % 24 ))"
    (( hours %= 24 ))

    # Get the remainding minutes.
    (( minutes %= 60 ))

    eprintf "Final   hours: %d\n" "${hours}"
    eprintf "Final minutes: %d\n" "${minutes}"

    eprintf "%02d:%02d\n" "${hours}" "${minutes}"
    ${DEBUG} || printf "%02d:%02d\n" "${hours}" "${minutes}"
} # main()

# Run the main function.
main "${@}"
