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
    local start="${1}"
    local end="${2:-0}"

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # One or two arguments?
    if [[ ${#vargs[@]} -lt 1 ]] || [[ ${#vargs[@]} -gt 2 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        #show_usage
        printf "%s\n" "1 or 2 arguments expected"
        (( retval++ ))

    # First argument: a number?
    elif [[ ! ${start} =~ ^[0-9]+$ ]]; then
        eprintf "ERROR: start line number [%s] can only be a positive number.\n" "${start}"
        show_usage
        (( retval++ ))

    # Second argument: a number?
    elif [[ ! ${end} =~ ^[0-9]+$ ]]; then
        eprintf "ERROR: end line number [%s] can only be a positive number.\n" "${end}"
        show_usage
        (( retval++ ))

    # First argument: between 0 and 99?
    elif [[ ${start} -lt 0 ]] || [[ ${start} -gt 99 ]]; then
        eprintf "ERROR: start line number [%s] needs to be between 0 and 99.\n" "${start}"
        show_usage
        (( retval++ ))

    # Second argument: between 0 and 99?
    elif [[ ${end} -lt 0 ]] || [[ ${end} -gt 99 ]]; then
        eprintf "ERROR: end line number [%s] needs to be between 0 and 99.\n" "${end}"
        show_usage
        (( retval++ ))

    # Is start greater than end?
    elif [[ ${start} -lt "${end}" ]]; then
        eprintf "ERROR: Start [%d] must be greater than end [%d].\n" "${start}" "${end}"
        #show_usage
        printf "%s\n" "Start must be greater than End"
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
        printf "%s\n\n" "Recite the lyrics to that beloved classic, that field-trip favorite: 99 Bottles of Beer on the Wall."
        printf "Usage: %s <start line number> <optional end line number>" "$0"
        printf "\n"
    } >&2
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: Generates lyrics for the beer song.
# Input : start (int), end (int)
# Output: lyrics
# Return: 0
beer_song()
{
    local -i start="${1:-99}"
    local -i end="${2:-${start}}"

	local line_format_string1="%d bottle%s of beer on the wall, %d bottle%s of beer.\n"
	local line_format_string2="Take one down and pass it around, %d bottle%s of beer on the wall.\n"
	local line1
	local line2
	local -a output
    local -i beer_count
    local -a lyrics

    beer_count="${start}"

    while [[ ${beer_count} -ge ${end} ]]; do

        if [[ ${beer_count} -ge 1 ]]; then

            if (( beer_count > 1 )); then
                plural="s"
            else
                plural=""
            fi

            # shellcheck disable=SC2059
            line1="$(printf "${line_format_string1}" "${beer_count}" "${plural}" "${beer_count}" "${plural}")"

            if [[ ${beer_count} -gt 0 ]]; then
                (( beer_count-- ))
            fi

            if (( beer_count > 1 )); then
                plural="s"
            else
                plural=""
            fi

            if [[ ${beer_count} -gt 0 ]]; then
                # shellcheck disable=SC2059
                line2="$(printf "${line_format_string2}" "${beer_count}" "${plural}")"
            else
                line2="Take it down and pass it around, no more bottles of beer on the wall."
            fi

        else

            line1="No more bottles of beer on the wall, no more bottles of beer."
            line2="Go to the store and buy some more, 99 bottles of beer on the wall."

            (( beer_count-- ))

        fi

        lyrics+=( "${line1}" "${line2}" )

        #eprintf "[%d] %s\n" "${i}" "${line}"
        #eprintf "\n"

	done

	#eprintf "\n"

	printf "%s\n" "${lyrics[@]}"
} # beer_song()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local -i start="${1}"
    local -i end="${2:-${start}}"

    local -a output
    local -i index
    local line

    eprintf "\n"
    eprintf "Start Line: [%d]\n" "${start}"
    eprintf "  End Line: [%d]\n" "${end}"

    mapfile -t output < <(beer_song "${start}" "${end}")

    index=0
    for line in "${output[@]}"; do
        eprintf "%s\n" "${line}"
        ${DEBUG} || printf "%s\n" "${line}"
        (( index++ ))

        if (( index % 2 == 0 )); then
            eprintf "\n"
            ${DEBUG} || printf "\n"
        fi
    done
} # main()

# Run the main function.
main "${@}"
