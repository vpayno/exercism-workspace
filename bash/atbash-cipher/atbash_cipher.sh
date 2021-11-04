#!/usr/bin/env bash

# Enable/Disable debug output.
# This syntax let's us run it like this: DEBUG=true bash ./atbash_cipher.sh encode "message"
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
    local command="${1,,}"  # lowercase the string

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # Two arguments?
    if [[ ${#vargs[@]} -ne 2 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # First argument: Either encode or decode?
    elif [[ ! ${command} =~ ^(encode|decode)$ ]]; then
        eprintf "ERROR: command [%s] can either be encode or decode.\n" "${command}"
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
    printf "Usage: %s <encode|decode> \"<string>\"" "$0"
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

# Function: encode or decode the letter using the symmetric key
# Input : plain text letter or cipher text letter
# Output: cipher text letter or plain text letter
# Return: 0
atbash_encode_decode_letter()
{
    local input_letter="${1,,}"

    local output_letter

    # This feels like a bug or that we should change 0-9 to 9-0 or refuse numbers.
    # The tests demand this works so...
    if [[ ${input_letter} =~ ^[[:digit:]]$ ]]; then
        # Pass the digit without encoding it.
        output_letter="${input_letter}"
    else
        # Encode the letter.
        output_letter="${key_table[${input_letter}]}"
    fi

    # Return the encoded/decoded letter.
    printf "%s" "${output_letter}"
} # atbash_encode_decode_letter()

# Function: atbash message encode or decode
# Input : plain text message or cipher text message
# Output: cipher text message or plain text message
# Return: 0
atbash_encode_decode_message()
{
    # lower case the string
    local command="${1,,}"

    # lower case the string
    local input_text="${2,,}"

    # remove all spaces from the string
    input_text="${input_text//[[:space:]]/}"

    # remove all punctuation from the string
    input_text="${input_text//[[:punct:]]/}"

    local -A key_table
    local letters
    local -i index="-1"
    local -i f
    local -i r
    local output_text
    local input_letter
    local output_letter

    if [[ ${command} == encode ]]; then
        eprintf "Encoding [%s]...\n" "${input_text}"
    else
        eprintf "Decoding [%s]...\n" "${input_text}"
    fi
    eprintf "\n"

    # Generate a string with the letters a to z.
    letters="$(printf "%s" {a..z})"

    # Generate a key table so we can translate a letter to it's output value.
    # f -> forward index
    # r -> reverse index
    for (( f=0, r=25; "${f}" <= 25; f++, r-- )); do
        # Instead of manually writing these out, let's auto-generate the key table.
        # shellcheck disable=SC2046
        eval $(printf "key_table[\"%s\"]=\"%s\"\n" "${letters:${f}:1}" "${letters:${r}:1}")
    done

    # Walk the letters of the input message string and encode the cipher text.
    for (( index=0; index < ${#input_text}; index++ )); do
        input_letter="${input_text:${index}:1}"

        [[ ${input_letter} == " " ]] && continue

        output_letter="$(atbash_encode_decode_letter "${input_letter}")"
        output_text+="${output_letter}"

        if [[ ${command} == encode ]] && [[ $(( (index + 1) % 5 )) -eq 0 ]]; then
            output_text+=" "
        fi

        eprintf "[%04d]: [%s] => [%s]\n" "${index}" "${input_letter}" "${output_letter}"
    done

    # Get rid of the trailing whitespace that gets added when the number of letters in
    # the cipher text is divisible by 5.
    [[ ${command} == encode ]] && output_text="$(trim "${output_text}")"

    printf "%s" "${output_text}"
} # atbash_encode_decode_message()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local command="${1,,}"
    local input="${2,,}"

    local input_text="${input}"
    local output_text

    output_text="$(atbash_encode_decode_message "${command}" "${input_text}")"

    eprintf "\n"
    eprintf "Command    : [%s]\n" "${command}"

    if [[ ${command} == encode ]]; then
        eprintf "Plain Text : "
    else
        eprintf "Cipher Text: "
    fi
    eprintf "[%s]\n" "${input_text}"

    if [[ ${command} == encode ]]; then
        eprintf "Cipher Text: "
    else
        eprintf "Plain Text : "
    fi
    eprintf "[%s]\n" "${output_text}"
    ${DEBUG} || printf "%s\n" "${output_text}"
} # main()

# Run the main function.
main "${@}"
