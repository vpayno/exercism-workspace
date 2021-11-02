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

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # Was a single argument passed?
    if [[ ${#vargs[@]} -ne 1 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # Is the single argument the word "total" or a number in the range 1-64 (inclusive)?
    elif [[ ${1,,} != total ]]; then
        if [[ ${1} -lt 1 ]] || [[ ${1} -gt 64 ]]; then
            eprintf "ERROR: The argument [%s] needs to be either \"total\" or a number between 1 and 64 (inclusive).\n" "${1,,}"
            printf "Error: invalid input\n"
            (( retval++ ))
        fi
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
check_args "$@" || exit "$?"

# Function: pretty print numbers
# Input : number
# Output: formatted string
pp()
{
    # Don't use -i so it doesn't overflow on large numbers.
    local number="${1}"

    sed -re ' :restart ; s/([0-9])([0-9]{3})($|[^0-9])/\1,\2\3/ ; t restart ' <<< "${number}"
}

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0 (success) or >=1 (error)
main()
{
    local input="${1,,}"
    local mode="square"  # square or total

    local -i index=0

    # Don't use BASH integers, the numbers get too big on square 64.
    local grains=1
    local total=0

    if [[ ${input} == total ]]; then
        mode="total"
    fi

    eprintf " #    grains in square             total grains\n"

    # Walk the letters of the first string and compare them to the second string.
    for (( index=1; index <= 64; index++ )); do
        # This will overflow on square 64.
        #(( total+=grains ))

        total="$(bc <<< "${total} + ${grains}")"

        # Don't use %d for the grains and total columns.
        eprintf "[%2d] [%26s] [%26s]\n" "${index}" "$(pp "${grains}")" "$(pp "${total}")"

        if [[ ${mode} == square ]]; then
            if [[ ${index} -eq ${input} ]]; then
                break
            fi
        fi

        # This will overflow on square 64.
        #(( grains*=2 ))

        grains="$(bc <<< "${grains} * 2")"
    done

    eprintf "\n"
    if [[ ${mode} == square ]]; then
        eprintf "Grains on Square %d: " "${index}"
        if ${DEBUG}; then
            printf "%s\n" "$(pp "${grains}")"
        else
            printf "%s\n" "${grains}"
        fi
    else
        eprintf "Total: "
        if ${DEBUG}; then
            printf "%s\n" "$(pp "${total}")"
        else
            printf "%s\n" "${total}"
        fi
    fi
}

# Run the main function.
main "${@}"
