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
}

# Function: check the validity of the script's arguments.
# Input : script arguments
# Output: error messages
# Return: 0 (valid) or >=1 (one or more input problems found)
check_args()
{
    # Capture the script's arguments.
    local -a vargs=( "$@" )

    # Don't use -i here, it masks leading zeros.
    local number="${1}"
    local digit="${number// /}"

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # Single argument?
    if [[ ${#vargs[@]} -ne 1 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # Strings of length 1 are invalid.
    elif [[ ${#digit} -eq 1 ]]; then
        eprintf "ERROR: single digits [%s] aren't valid.\n" "${number}"
        printf "%s\n" "false"
        (( retval++ ))

    # Were only digits with optional whitespace passed?
    elif [[ ! ${number} =~ ^([[:digit:]]|[ ])+$ ]]; then
        eprintf "ERROR: string [%s] can only consist of valid characters [0-9 or space].\n" "${number}"
        printf "%s\n" "false"
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
    printf "Usage: %s <string1> <string2>" "$0"
}

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit 0

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0 (success) or >=1 (error)
main()
{
    # Treat as strings.
    local input="${1}"
    local register=""
    local number=""

    local -i index="1"  # using to determine which numbers to skip
    local -i rindex="0" # right-index for walking the string backwards
    local -i sum="0"

    local valid="false"

    # Walk the letters of the input string backwards.
    for (( rindex=${#input}-1; rindex >= 0; rindex-=1 )); do

        number="${input:${rindex}:1}"
        if [[ ${number} != " " ]]; then

            # Do some math on the number on every other digit from the right.
            if [[ $(( index % 2 )) -eq 0 ]]; then
                (( number*=2 ))
                eprintf "string[%02d]: %d * 2 = %d\n" "${index}" "$(( number / 2 ))" "${number}"

                if [[ ${number} -gt 9 ]]; then
                    (( number-=9 ))
                    eprintf "string[%02d]: %d - 9 = %d\n" "${index}" "$(( number - 9 ))" "${number}"
                fi

            fi

            # Append the unaltered or altered number to the left of the new register.
            register="${number}${register}"
            eprintf "[%s]\n" "${register}"

            # Sum the digits as we go.
            (( sum+=number ))
            eprintf "sum: %d + %d = %d\n" "$(( sum - number ))" "${number}" "${sum}"

            eprintf "\n"

            (( index++ ))

        else
            # Append space to the left of the register.
            register="${number}${register}"
            eprintf "[%s]\n" "${register}"
        fi

    done

    # If the sum is divisible by 10, it's valid.
    if [[ $(( sum % 10 )) -eq 0  ]]; then
        valid="true"
    fi

    eprintf "\n"
    eprintf "Input   : %s\n" "${input}"
    eprintf "Register: %s\n" "${register}"
    eprintf "Sum     : %s\n" "${sum}"
    eprintf "\n"
    eprintf "Valid: "
    printf "%s\n" "${valid}"
}

# Run the main function.
main "${@}"
