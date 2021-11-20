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
# This syntax let's us run it like this: DEBUG=true bash ./script_name.sh argument(s)
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
}

# Function: check the validity of the script's arguments.
# Input : checks global scope variables for validity.
# Output: error messages
# Return: 0 (valid) or >=1 (one or more input problems found)
check_args()
{
    # Capture the script's arguments.
    local -a vargs=( "$@" )
    local sequence="${1^^}"

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # Were more than one argument passed?
    if [[ ${#vargs[@]} -ne 1 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # Are both sequences only compused of the letters C, A, G and T  or is an empty string?
    elif [[ ! ${sequence} =~ ^([ACGT]+|)$ ]]; then
        eprintf "ERROR: sequence [%s] has characters other than [ACGT].\n" "${sequence}"
        #show_usage
        printf "Invalid nucleotide in strand" # what the tests expect
        (( retval++ ))
    fi

    # If a non-zero value is returned, it means that one or more tests have failed.
    return "${retval}"
}

# Function: print the scripts usage help message.
# Input : none
# Output: usage help screen
# Return: 1 (always)
show_usage()
{
    printf "Usage: %s \"<ACGT Sequence>\"" "$0"
}

check_args "$@" || exit "$?"

# Function: counts the nucleotides in a ACGT sequence
# Input : one ACGT sequence string
# Output: associative array with the counts
# Return: 0
nucleotide_counter()
{
    local sequence="${1^^}"

    local -A -i counts=(
        ["A"]=0
        ["C"]=0
        ["G"]=0
        ["T"]=0
    )

    local -i index="0"
    local key
    local char

    # Walk the letters of the string and count the nucleotides.
    for (( index=0; index < ${#sequence}; index++ )); do
        char="${sequence:${index}:1}"
        counts[${char}]+=1

        eprintf "[%s] count is now [%d]\n" "${char}" $(( ${counts[${char}]} ))
    done

    eprintf "\n"
    eprintf "Input sequence: [%s]\n" "${sequence}"
    eprintf "\nNucleotide Counts: "
    ${DEBUG} && declare -A -p counts
    eprintf "\n"

    # Dictionary keys need to be sorted so the tests pass (they expect A, C, G and T).
    for key in "${!counts[@]}"; do
        printf "%s: %d\n" "${key}" "${counts[${key}]}"
    done | sort -k 1,1
} # nucleotide_counter()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local sequence="${1}"

    nucleotide_counter "${sequence}"
} # main()

# Run the main function.
main "${@}"
