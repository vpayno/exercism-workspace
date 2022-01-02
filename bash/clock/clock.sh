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

    # Two arguments or Four arguments?
    if [[ ${#vargs[@]} -lt 2 ]] || [[ ${#vargs[@]} -eq 3 ]] || [[ ${#vargs[@]} -gt 4 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        printf "ERROR: %s.\n" "invalid arguments"
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

    elif [[ ${#vargs[@]} -eq 4 ]] && [[ ! ${sign} =~ ^[-+]$ ]]; then
        eprintf "ERROR: sign [%s] can either be \"+\" or \"-\".\n" "${sign}"
        printf "ERROR: %s.\n" "invalid arguments"
        show_usage
        (( retval++ ))

    elif [[ ${#vargs[@]} -eq 4 ]] && [[ ! ${delta} =~ ^[0-9]+$ ]]; then
        eprintf "ERROR: delta[%s] can either be postitive or negative integer.\n" "${delta}"
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
check_args "$@" || exit "$?"

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local -i input_hours="${1}"
    local -i input_minutes="${2}"
    local input_sign="${3}"
    local -i input_delta="${4}"

    local -i hours=0
    local -i minutes=0

    minutes="${input_hours} * 60"
    eprintf "minutes (%d) = input_hours (%d) * 60\n" "${minutes}" "${input_hours}"

    eprintf "minutes (%d) = minutes (%d) - input_minutes (%d)\n" "$(( minutes - input_minutes ))" "${minutes}" "${input_minutes}"
    minutes="${minutes} + ${input_minutes}"

    if [[ -n ${input_sign} ]]; then
        minutes="${minutes} ${input_sign} ${input_delta}"
        eprintf "minutes (%d) = minutes (%d) %s input_delta (%d)\n" "$(( minutes + ${input_sign}input_delta ))" "${minutes}" "${input_sign}" "${input_delta}"
    fi

    (( hours = minutes / 60 ))
    eprintf "  hours (%d) = minutes (%d) / 60 ))\n" "${hours}" "${minutes}"
    eprintf "minutes (%d) = minutes (%d) / 60 ))\n" "$(( minutes / 60 ))" "${minutes}"
    (( minutes = minutes % 60 ))

    if [[ ${minutes} -lt 0 ]]; then
        minutes="60 + ${minutes}"
        hours="${hours} + -1"
    fi

    eprintf "[%d]h : [%d]m\n" "${hours}" "${minutes}"

    if [[ ${hours} -lt 0 ]]; then
        (( hours = hours % 24 ))
        hours="24 + ${hours}"
    fi

    eprintf "[%d]h : [%d]m\n" "${hours}" "${minutes}"

    (( hours %= 24 ))

    eprintf "[%d]h : [%d]m\n" "${hours}" "${minutes}"

    eprintf "\n"

    eprintf "Final   hours: %d\n" "${hours}"
    eprintf "Final minutes: %d\n" "${minutes}"

    eprintf "%02d:%02d\n" "${hours}" "${minutes}"
    ${DEBUG} || printf "%02d:%02d\n" "${hours}" "${minutes}"
} # main()

# Run the main function.
main "${@}"
