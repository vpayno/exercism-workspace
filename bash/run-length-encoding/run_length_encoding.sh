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
    local command="${1,,}"  # lower case the string
    local text="${2}"

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

    # First argument: encode?
    elif [[ ${command} =~ ^encode$ ]]; then
        if [[ ${text} =~ [0-9]+ ]]; then
            eprintf "ERROR: string to encode [%s] can't contain digits.\n" "${text}"
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
        printf "%s\n\n" "Run-length encoding (RLE) is a simple form of data compression, where runs (consecutive data elements) are replaced by just one data value and count."
        printf "Usage: %s \"%s\" '\%s\"\n" "<encode|decode>" "<[A-Z]+>" "$0"
        printf "\n"
    } >&2
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: run-length-encoding message encode or decode
# Input : command & plain text message or cipher text message
# Output: cipher text message or plain text message
# Return: 0
run_length_encoding()
{
    # lower case the string
    local command="${1,,}"
    local input_text="${2}"

    local -i index="-1"
    local output_text
    local char
    local chars
    local last_char
    local -i count=0

    if [[ ${command} == encode ]]; then
        eprintf "Encoding [%s]...\n" "${input_text}"
    elif [[ ${command} == decode ]]; then
        eprintf "Decoding [%s]...\n" "${input_text}"
    fi
    eprintf "\n"

    if [[ ${command} == encode ]]; then

        # Walk the chars of the input message string and encode the cipher text.
        for (( index=0; index < ${#input_text}; index++ )); do

            char="${input_text:${index}:1}"

            if [[ ${last_char} == "${char}" ]]; then
                (( count++ ))
                continue
            else
                if [[ ${count} -le 1 ]]; then
                    output_text="${output_text}${last_char}"
                else
                    output_text="${output_text}${count}${last_char}"
                fi

                last_char="${char}"
                count=1
            fi

        done

        if [[ ${count} -le 1 ]]; then
            output_text="${output_text}${char}"
        else
            output_text="${output_text}${count}${char}"
        fi

    elif [[ ${command} == decode ]]; then

        # Walk the chars of the input message string and encode the cipher text.
        for (( index=0; index < ${#input_text}; index++ )); do

            char="${input_text:${index}:1}"

            if [[ "${char}" =~ [[:digit:]] ]]; then
                if [[ ${count} -gt 0 ]]; then
                    count="${count}${char}"
                else
                    count="${char}"
                fi

                continue
            fi

            if [[ ${count} -gt 0 ]]; then
                printf -v chars "%.s${char}" $(seq 1 "${count}")

                output_text="${output_text}${chars}"
                count=0
            else
                output_text="${output_text}${char}"
            fi

        done

    fi

    printf "%s" "${output_text}"
} # run_length_encoding()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local command="${1,,}"
    local input_text="${2}"

    local text="${input_text}"
    local output_text

    output_text="$(run_length_encoding "${command}" "${text}")"

    eprintf "\n"
    eprintf "Command    : [%s]\n" "${command}"

    if [[ ${command} == encode ]]; then
        eprintf "Plain Text : "
    else
        eprintf "Cipher Text: "
    fi
    eprintf "[%s]\n" "${input_text}"
    eprintf "%s\n" "${input_text}"

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
