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
    local input_sequence="${1^^}"  # uppercase the string

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # Two arguments?
    if [[ ${#vargs[@]} -ne 1 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # Only ACGU letters?
    elif [[ ! ${input_sequence} =~ ^[ACGU]+$ ]]; then
        eprintf "ERROR: [%s] can only contain the letters ACGU.\n" "${input_sequence}"
        #show_usage
        printf "%s\n" "Invalid codon"
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
    printf "Usage: %s \"<ACGU sequence>\"" "$0"
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

# Function: Translates protein sequences to English.
# Input : ACGU sequence string
# Output: Protein string in English
# Return: 0
translate_protein()
{
    local sequence="${1^^}"
    local -a codons

    read -r -a codons < <(sed -r -e ' :restart ; s/([A-Z])([A-Z]{3})($|[^A-Z])/\1 \2\3/ ; t restart ' <<< "${sequence}")

    for codon in "${codons[@]}"; do
        eprintf "Examining string [%s] -> " "${codon}"

        case "${codon}" in
        AUG)
            protein_name="Methionine"
            ;;
        UUU|UUC)
            protein_name="Phenylalanine"
            ;;
        UUA|UUG)
            protein_name="Leucine"
            ;;
        UCU|UCC|UCA|UCG)
            protein_name="Serine"
            ;;
        UAU|UAC)
            protein_name="Tyrosine"
            ;;
        UGU|UGC)
            protein_name="Cysteine"
            ;;
        UGG)
            protein_name="Tryptophan"
            ;;
        UAA|UAG|UGA)
            protein_name="STOP"
            eprintf "%s\n" "${protein_name}"
            break
            ;;
        esac

        eprintf "%s\n" "${protein_name}"
        [[ ${protein_name} == STOP ]] || printf "%s " "${protein_name}"
    done
} # translate_protein()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local input_sequence="${1^^}"

    local output_text

    eprintf "Input: [%s]\n" "${input_sequence}"

    output_text="$(trim "$(translate_protein "${input_sequence}")")"

    eprintf "Output: [%s]\n" "${output_text}"

    ${DEBUG} || printf "%s\n" "${output_text}"
} # main()

# Run the main function.
main "${@}"
