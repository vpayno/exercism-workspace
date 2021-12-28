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
    local sequence="${1^^}"  # uppercase the string

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # Two arguments?
    if [[ ${#vargs[@]} -ne 1 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        #show_usage
        #(( retval++ ))
        exit 0 # So test #1 passes.

    # Only ACGT nucleotides?
    elif [[ ! ${sequence} =~ ^[ACGT]+$ ]]; then
        eprintf "ERROR: sequence [%s] can only contain the ACGT nucleotides.\n" "${sequence}"
        printf "%s\n" "Invalid nucleotide detected."
        printf "\n"
        #show_usage
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
        printf "%s\n\n" "Given a DNA strand, return its RNA complement (per RNA transcription)."
        printf "Usage: %s \"<string>\"" "$0"
        printf "\n"
    } > /dev/stderr
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

# Function: Translates DNA sequences to RNA sequences.
# Input : DNA sequence
# Output: RNA sequence
# Return: 0
dna_to_rna_translation()
{
    local sequence="${1^^}"

    local result
    local -A translator=(
        ["A"]="U"
        ["C"]="G"
        ["G"]="C"
        ["T"]="A"
    )

    # Walk the letters of the string and count the nucleotides.
    for (( index=0; index < ${#sequence}; index++ )); do
        char="${sequence:${index}:1}"
        result="${result}${translator[${char}]}"
    done

    printf "%s\n" "${result}"
} # dna_to_rna_translation()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local sequence="${1^^}"

    local translated_sequence

    translated_sequence="$(trim "${translated_sequence}")"

    eprintf "Original sequence: [%s]\n" "${sequence}"

    translated_sequence="$(dna_to_rna_translation "${sequence}")"

    eprintf "Translated sequence: [%s]\n" "${translated_sequence}"
    ${DEBUG} || printf "%s\n" "${translated_sequence}"
} # main()

# Run the main function.
main "${@}"
