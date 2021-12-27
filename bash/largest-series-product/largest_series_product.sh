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
    local sequence="${1,,}"  # lowercase the string
    local length="${2}"

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # Two arguments?
    if [[ ${#vargs[@]} -eq 1 ]]; then
        eprintf "Corner case, empty sequence with a span of 0.\n" "${vargs[*]}" "${#vargs[@]}"
        printf "%d\n" 1
        # don't fail
        exit 0

    elif [[ ${#sequence} -gt 0 ]] && [[ ${length} -eq 0 ]]; then
        eprintf "Corner case, sequence with a span of 0.\n" "${vargs[*]}" "${#vargs[@]}"
        printf "%d\n" 1
        # don't fail
        exit 0

    elif [[ ${#sequence} -eq 0 ]] && [[ ${length} -eq 0 ]]; then
        eprintf "Corner case, empty sequence with a span of 0.\n" "${vargs[*]}" "${#vargs[@]}"
        printf "%d\n" 1
        # don't fail
        exit 0

    elif [[ ${#vargs[@]} -ne 2 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # Span length smaller than or equal to the length of the sequence?
    elif [[ ${length} -gt ${#sequence} ]]; then
        eprintf "ERROR: the span length [%s] needs to be smaller than the sequence length [%s].\n" "${length}" "${#sequence}"
        printf "span must be smaller than string length\n"
        eprintf "\n"
        show_usage
        (( retval++ ))

    # Span length must be larger than 0.
    elif [[ ${length} -lt 0 ]]; then
        eprintf "ERROR: the span length [%s] needs to be than 0.\n" "${length}" "${#sequence}"
        printf "span must be greater than zero\n"
        eprintf "\n"
        show_usage
        (( retval++ ))

    # First argument: only numbers?
    elif [[ ! ${sequence} =~ ^[0-9]+$ ]]; then
        eprintf "ERROR: sequence [%s] can only contain numbers.\n" "${sequence}"
        printf "input must only contain digits\n"
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
        printf "%s\n\n" "Given a string of digits, calculate the largest product for a contiguous substring of digits of length n."
        printf "Usage: %s numeric-sequence length" "$0"
        printf "\n"
    } >&2
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: Given a string of digits, calculate the largest product for a contiguous substring of digits of length n.
# Input : digit sequence, n
# Output: largest series product
# Return: 0
largest_series_product()
{
    local sequence="${1}"
    local -i length="${2}"

    local -a -i numbers
    local -i i
    local -i j

    local -a -i last_products
    local -a -i next_products
    local -i last_product=0
    local -i next_product=0

    read -r -a numbers <<< "$(sed -r -e 's/(.)/\1 /g' <<< "${sequence}")"

    i=0
    while [[ ${i} -lt ${#sequence} ]]; do

        j="${i}"
        next_product=-1
        next_products=()
        while [[ ${j} -lt $(( i + length )) ]] && (( i + length <= ${#sequence} )); do

            if [[ ${next_product} -ge 0 ]]; then
                (( next_product *= ${numbers[${j}]} ))
            else
                (( next_product = ${numbers[${j}]} ))
            fi

            next_products+=( "${numbers[${j}]}" )

            (( j++ ))
        done

        if [[ ${next_product} -gt ${last_product} ]]; then
            eprintf "Found next LSP [%s] = [%d]\n" "${last_products[*]}" "${last_product}"

            last_product="${next_product}"
            last_products=( "${next_products[@]}" )
        fi

        (( i++ ))
    done

    printf "%s" "${last_product}"
} # largest_series_product()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    # Treat the sequence as a string because it can start with a 0.
    local sequence="${1}"
    local -i length="${2}"

    local -i result

    eprintf "Sequence: [%s]\n" "${sequence}"
    eprintf "       n: [%d]\n" "${length}"
    eprintf "\n"

    result="$(largest_series_product "${sequence}" "${length}")"

    eprintf "Largest Series Product: [%d]\n" "${result}"
    ${DEBUG} || printf "%d\n" "${result}"
} # main()

# Run the main function.
main "${@}"
