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

    # Was one argument passed?
    if [[ ${#vargs[@]} -ne 1 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))
    fi

    # Does the string consist of only letters or is empty?
    if [[ ! ${1} =~ ^[[:alpha:]]*$ ]]; then
        eprintf "ERROR: Only use letters or an empty string as an argument [%s]\n" "${1}"
        show_usage
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
    printf "Usage: %s \"<string>\"" "$0"
}

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0 (success) or >=1 (error)
main()
{
    local input="${1^^}"

    local -i index="-1"
    local -i score=0
    local letter
    local -A points

    points["A"]=1
    points["B"]=3
    points["C"]=3
    points["D"]=2
    points["E"]=1
    points["F"]=4
    points["G"]=2
    points["H"]=4
    points["I"]=1
    points["J"]=8
    points["K"]=5
    points["L"]=1
    points["M"]=3
    points["N"]=1
    points["O"]=1
    points["P"]=3
    points["Q"]=10
    points["R"]=1
    points["S"]=1
    points["T"]=1
    points["U"]=1
    points["V"]=4
    points["W"]=4
    points["X"]=8
    points["Y"]=4
    points["Z"]=10

    # Walk the letters of the first string and compare them to the second string.
    for (( index=0; index < ${#input}; index++ )); do
        letter="${input:${index}:1}"

        (( score += ${points[${letter}]} ))
    done

    eprintf "\n"
    eprintf "Word : %s\n" "${input}"
    eprintf "\n"
    eprintf "Score: "
    printf "%d\n" "${score}"
}

# Run the main function.
main "${@}"
