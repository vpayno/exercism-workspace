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

    # One argument?
    if [[ ${#vargs[@]} -gt 1 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # Is the argument a number?
    elif [[ ! ${command} =~ ^[0-9]+$ ]]; then
        eprintf "ERROR: the arument [%s] isn't a number.\n" "${command}"
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
    printf "Usage: %s \"<string>\"" "$0"
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: trim punctuation at the end and start of the string.
# Input : string
# Output: string with no leading or traling whitespace
# Return: 0 (trimmed) or 1 (not trimmed)
trim()
{
    local line="${1}"

    # remove traling whitespace
    line="${line#"${line%%[![:punct:]]*}"}"

    # remove leading whitespace
    line="${line%"${line##*[![:punct:]]}"}"

    printf "%s" "${line}"
}

# Function: convert decimal to binary
# Input : decimal number
# Output: binary number
# Return: 0 (valid input) 1 (invalid input)
dec2bin()
{
    local -i number="${1}"

    # Decimal to binary magic for numbers between 0-255.
    # This expands to a binary array: 00000 00001 00010 00011 ...
    local -a binary_magic=( {0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1} )
    local binary

    if [[ ${number} -lt 0 ]]; then
        eprintf "ERROR: number [%d] is less than 0.\n" "${number}"
        return 1
    elif [[ ${number} -ge 0 ]] && [[ ${number} -le 255 ]]; then
        binary="${binary_magic[${number}]}"
    else
        # This program won't use this but here's another cool way to do this.
        binary="$(printf "%08d" "$(bc <<< "obase=2; ${number}")")"
    fi

    printf "%s" "${binary}"
} # dec2bin()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local -i decimal="${1}"

    local direction="forward"
    local binary
    local secret_handshake
    local -A handshake_steps

    # 0x1   1
    handshake_steps["00000001"]="wink"
    # 0x2   2
    handshake_steps["00000010"]="double blink"
    # 0x4   4
    handshake_steps["00000100"]="close your eyes"
    # 0x8   8
    handshake_steps["00001000"]="jump"
    # 0x10 16
    handshake_steps["00010000"]="reverse"

    # 2# -> base 2 (used in Bash arithmetic expressions)
    binary="2#$(dec2bin "${decimal}")"

    # The arithmetic expression is checking to see if the 5th bit is turned on.
    if (( (binary & 2#00010000) == "2#00010000" )); then
        direction="reverse"
    fi

    if (( (binary & 2#00000001) == 1 )); then
        if [[ ${direction} == "reverse" ]]; then
            secret_handshake="${handshake_steps[00000001]}"
        else
            secret_handshake="${handshake_steps[00000001]},"
        fi
    fi
    eprintf "secret_handshake=[%s]\n" "${secret_handshake}"

    if (( (binary & 2#00000010) == 2 )); then
        if [[ ${direction} == "reverse" ]]; then
            secret_handshake="${handshake_steps[00000010]},${secret_handshake}"
        else
            secret_handshake+="${handshake_steps[00000010]},"
        fi
    fi
    eprintf "secret_handshake=[%s]\n" "${secret_handshake}"

    if (( (binary & 2#00000100) == 4 )); then
        if [[ ${direction} == "reverse" ]]; then
            secret_handshake="${handshake_steps[00000100]},${secret_handshake}"
        else
            secret_handshake+="${handshake_steps[00000100]},"
        fi
    fi
    eprintf "secret_handshake=[%s]\n" "${secret_handshake}"

    if (( (binary & 2#00001000) == 8 )); then
        if [[ ${direction} == "reverse" ]]; then
            secret_handshake="${handshake_steps[00001000]},${secret_handshake}"
        else
            secret_handshake+="${handshake_steps[00001000]}"
        fi
    fi
    eprintf "secret_handshake=[%s]\n" "${secret_handshake}"
    eprintf "\n"

    secret_handshake="$(trim "${secret_handshake}")"

    eprintf "Input Number       : [%d]\n" "${decimal}"
    eprintf "Binary Number      : [%08s]\n" "${binary##*#}"
    eprintf "Handshake Direction: [%s]\n" "${direction}"
    eprintf "Secret Handshake   : [%s]\n" "${secret_handshake}"
    ${DEBUG} || printf "%s\n" "${secret_handshake}"
} # main()

# Run the main function.
main "${@}"
