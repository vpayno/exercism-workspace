#!/usr/bin/env bash

# Enable/Disable debug output.
declare DEBUG="false"


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
