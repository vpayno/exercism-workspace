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
    local sequence="${1}"
    local length="${2}"

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # Two arguments?
    if [[ ${#vargs[@]} -ne 2 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # First argument: empty?
    elif [[ ${sequence} =~ ^$ ]]; then
        eprintf "ERROR: sequence [%s] can't be empty.\n" "${sequence}"
        printf "series cannot be empty\n"
        eprintf "\n"
        show_usage
        (( retval++ ))

    # Slice length smaller than or equal to the length of the sequence?
    elif [[ ${length} -gt ${#sequence} ]]; then
        eprintf "ERROR: the slice length [%s] needs to be smaller or equal to the sequence length [%s].\n" "${length}" "${#sequence}"
        printf "slice length cannot be greater than series length\n"
        eprintf "\n"
        show_usage
        (( retval++ ))

    # Slice length can't be 0.
    elif [[ ${length} -eq 0 ]]; then
        eprintf "ERROR: the slice length [%s] needs to be greater than 0.\n" "${length}" "${#sequence}"
        printf "slice length cannot be zero\n"
        eprintf "\n"
        show_usage
        (( retval++ ))

    # Slice length can't be negative.
    elif [[ ${length} -lt 0 ]]; then
        eprintf "ERROR: the slice length [%s] needs to be greater than 0.\n" "${length}" "${#sequence}"
        printf "slice length cannot be negative"
        eprintf "\n"
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
        printf "%s\n\n" "Given a string of digits, output all the contiguous substrings of length n in that string in the order that they appear."
        printf "Usage: %s numeric-sequence length" "$0"
        printf "\n"
    } >&2
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: Given a string of digits, output all the contiguous substrings of length n in that string in the order that they appear.
# Input : digit sequence, n
# Output: largest series product
# Return: 0
substring_generator()
{
    local sequence="${1}"
    local -i length="${2}"

    local -a -i numbers
    local -i i
    local -i j

    local -a collection
    local next

    read -r -a numbers <<< "$(sed -r -e 's/(.)/\1 /g' <<< "${sequence}")"

    i=0
    while [[ ${i} -lt ${#sequence} ]] && (( ${#sequence} - i >= length )); do

        j="${i}"
        next=""
        while [[ ${j} -lt $(( i + length )) ]] && (( i + length <= ${#sequence} )); do

            eprintf "next=%s%s\n" "${next}" "${numbers[${j}]}"
            next="${next}${numbers[${j}]}"

            (( j++ ))
        done

        eprintf "collection+=( %s )\n" "${next}"
        collection+=( "${next}" )

        (( i++ ))
    done

    printf "%s\n" "${collection[@]}"
} # substring_generator()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    # Treat the sequence as a string because it can start with a 0.
    local sequence="${1}"
    local -i length="${2}"

    local -a result

    eprintf "Sequence: [%s]\n" "${sequence}"
    eprintf "       n: [%d]\n" "${length}"
    eprintf "\n"

    mapfile -t result <<< "$(substring_generator "${sequence}" "${length}")"

    eprintf "  Series: [%s]\n" "${result[*]}"
    ${DEBUG} || printf "%s\n" "${result[*]}"
} # main()

# Run the main function.
main "${@}"
