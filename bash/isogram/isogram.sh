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

    # Empty string or only letters, spaces or punctuation?
    elif [[ ! ${input} =~ ^(|[[:alpha:]]|[[:space:]]|[[:punct:]])+$ ]]; then
        eprintf "ERROR: input [%s] can only contain letters, spaces and punctuation.\n" "${input}"
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
        printf "%s\n\n" "Determine if a word or phrase is an isogram."
        printf "Usage: %s \"<string>\"" "$0"
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

# Function: Test string to see if it's an isogram.
# Input : string
# Output: true or false
# Return: 0 (true) or 1 (false)
is_isogram()
{
    local input="${1,,}"

    local -A -i counter
    local -i index
    local char
    local result="true"
    local -i retval=0

    # Walk the letters of the string and count them.
    for (( index=0; index < ${#input}; index++ )); do
        char="${input:${index}:1}"

        if [[ ${counter[${char}]:-0} -eq 0 ]]; then
            (( counter[${char}]++ ))
        else
            result="false"
            retval=1
            break
        fi
    done

    printf "%s" "${result}"
    return "${retval}"
} # is_isogram()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local input="${1,,}"

    local output

    eprintf "Input: [%s]\n" "${input}"

    input="$(trim "${input}")"
    input="$(tr -d '[:digit:][:punct:][:space:]' <<< "${input}")"

    output="$(is_isogram "${input}")"

    eprintf "Is isogram? [%s]\n" "${output}"
    ${DEBUG} || printf "%s\n" "${output}"
} # main()

# Run the main function.
main "${@}"
