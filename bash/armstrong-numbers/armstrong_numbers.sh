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
}

# Function: check the validity of the script's arguments.
# Input : script arguments
# Output: error messages
# Return: 0 (valid) or >=1 (one or more input problems found)
check_args()
{
    # Capture the script's arguments.
    local -a vargs=( "$@" )
    local number="${vargs[0]}"

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # Did we only get one argument?
    if [[ ${#vargs[@]} -ne 1 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # Is the argument a number?
    elif [[ ! ${number} =~ ^[0-9]+$ ]]; then
        eprintf "ERROR: the argument is not a positive interger [%s].\n" "${number}"
        printf "NaN\n"
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
    printf "Usage: %s <integer>" "$0"
}

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0 (success) or >=1 (error)
main()
{
    local input="${1}"

    local -i index=0
    local -i exponent
    local -i pos
    local -i output
    local result="false" # true or false

    # The exponent is the number of digits in the number.
    exponent="${#input}"

    # Walk the number like a string array.
    for (( index=0; index < ${#input}; index++ )); do
        pos="${input:${index}:1}"

        (( output+=pos**exponent ))
    done

    # Does the input number equal the result of the equation?
    if [[ ${input} == "${output}" ]]; then
        result="true"
    fi

    eprintf "\n"
    eprintf "Input : %d\n" "${input}"
    eprintf "Output: %d\n" "${output}"
    eprintf "Is an Armstrong Number: "
    printf "%s\n" "${result}"
}

# Run the main function.
main "${@}"
