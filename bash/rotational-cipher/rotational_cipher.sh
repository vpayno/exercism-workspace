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
    local string="${1}"
    local key="${2}"

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # Two arguments?
    if [[ ${#vargs[@]} -ne 2 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # First argument: non-zero string?
    elif [[ -z ${string} ]]; then
        eprintf "ERROR: string [%s](%d) has to at least contain one character.\n" "${string}" "${#string}"
        show_usage
        (( retval++ ))

    # Second argument: Number?
    elif [[ ! ${key} =~ ^[0-9]+$ ]]; then
        if [[ ${key} -lt 0 ]] || [[ ${key} -gt 26 ]]; then
            eprintf "ERROR: key [%s] can only be a number between 0 and 26.\n" "${key}"
            show_usage
            (( retval++ ))
        fi

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
        printf "%s\n\n" "Ceasar cipher encoder."
        printf "Usage: %s \"<string>\" numeric-key" "$0"
        printf "\n"
    } >&2
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: Rotational Cipher Encoder
# Input : string
# Output: numeric key
# Return: 0
rot_cipher_encode()
{
    local input_text="${1}"
    local -i key="${2}"

    local -A in_lower
    local -A in_upper
    local -A out_lower
    local -A out_upper
    local -i i
    local c
    local -i index
    local -i outdex
    local in_char
    local out_char
    local output_text

    i=0
    for c in {a..z}; do
        in_lower["${c,,}"]="${i}"
        in_upper["${c^^}"]="${i}"

        out_lower["${i}"]="${c,,}"
        out_upper["${i}"]="${c^^}"

        #eprintf "[%s](%d)\n" "${c}" "${i}"
        (( i++ ))
    done

    #eprintf "in_lower: [%s]\n" "${in_lower[*]}"
    #eprintf "in_upper: [%s]\n" "${in_upper[*]}"
    #eprintf "out_lower: [%s]\n" "${out_lower[*]}"
    #eprintf "out_upper: [%s]\n" "${out_upper[*]}"
    #eprintf "\n"

    for (( i=0; i < ${#input_text}; i++ )); do
        in_char="${input_text:${i}:1}"

        if [[ ${in_char} =~ ^[[:upper:]]$ ]]; then
            index="${in_upper["${in_char}"]}"
            (( outdex = (index + key) % 26 ))
            out_char="${out_upper[${outdex}]}"
            eprintf "upper: [%s](%2d) => [%s](%2d)\n" "${in_char}" "${index}" "${out_char}" "${outdex}"

        elif [[ ${in_char} =~ ^[[:lower:]]$ ]]; then
            index="${in_lower["${in_char}"]}"
            (( outdex = (index + key) % 26 ))
            out_char="${out_lower[${outdex}]}"
            eprintf "lower: [%s](%2d) => [%s](%2d)\n" "${in_char}" "${index}" "${out_char}" "${outdex}"

        else
            out_char="${in_char}"
            #eprintf " pass: [%s] => [%s]\n" "${in_char}" "${out_char}"

        fi

        output_text="${output_text}${out_char}"
    done

    eprintf "\n"
    printf "%s" "${output_text}"
} # rot_cipher_encode()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local input="${1}"
    local -i key="${2}"

    local output

    output="$(rot_cipher_encode "${input}" "${key}")"

    eprintf " Plain Text: [%s](%d)\n" "${input}" "${key}"
    eprintf "Cipher Text: [%s]\n" "${output}"

    ${DEBUG} || printf "%s\n" "${output}"
} # main()

# Run the main function.
main "${@}"
