#!/usr/bin/env bash

# Enable/Disable debug output.
declare DEBUG="false"

# Capture the first two arguments.
declare seq1="${1:-}"
declare seq2="${2:-}"

# Force the sequence strings to uppercase.
seq1="${seq1^^}"
seq2="${seq2^^}"

# This holds our difference string/ruler.
declare seqdiff

# Function: printf to stderr if DEBUG is set to true
# Input : same as printf
# Output: same as printf, except it goes to stderr instead of stdout
# Return: from printf
eprintf()
{
    # Pass all the printf arguments and redirect stdout to stderr.
    ${DEBUG} && printf "$@" >&2
}

# Function: echo the length of a string.
# Input : single argument that's treated like a string.
# Output: length of passed argument.
# Return: 0 (always)
str_len()
{
    # Capture the function argument.
    local string="${1}"

    # Local variable section.
    local -i size=0

    # Get the length of the string.
    size="${#string}"

    # Echoing/printing the result because function return values are integers that range from 0-255.
    printf "%d" "${size}"

    # Always return successfully.
    return 0
}

# Function: check the validity of the script's arguments.
# Input : checks global scope variables for validity.
# Output: error messages
# Return: 0 (valid) or >=1 (one or more input problems found)
check_args()
{
    # Capture the script's arguments.
    local -a vargs=( "$@" )

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    local -i seq1_len
    local -i seq2_len

    # Since we're using $(), we want to track the exit code of the local command separate from this exit code.
    seq1_len="$(str_len "${seq1}")"
    seq2_len="$(str_len "${seq2}")"

    # Were more than two arguments passed?
    if [[ ${#vargs[@]} -ne 2 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))
    
    # Are both sequences of equal length?
    elif [[ ${seq1_len} -ne ${seq2_len} ]]; then
        eprintf "ERROR: sequence [%s](%d) and [%s](%d) are not of equal lengths.\n" "${seq1}" "${seq1_len}" "${seq2}" "${seq2_len}"
        printf "strands must be of equal length"
        (( retval++ ))

    # Are both sequences only compused of the letters C, A, G and T?
    # Joining the strings as a shortcut so we only run the test once.
    # Note: This prevents the last test that passes a "?" from working as expected so we need to also search for 
    # that character and allow it so that tests works as expected.
    elif [[ ! ${seq1}${seq2} =~ ^[CAGT?]+$ ]] && [[ ${seq1}${seq2} != "" ]]; then
        eprintf "ERROR: sequence [%s] and/or [%s] have characters other than [CAGT].\n" "${seq1}" "${seq2}"
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
    printf "Usage: %s <string1> <string2>" "$0"
}

check_args "$@" || exit "$?"

# Function: Calculates the Hamming Distance between two DNA strands.
# Input : two CAGT sequence strings
# Output: the sequence strings and the diff ruller.
# Return: 0 (identical) or >=1 (different)
calculate_hamming_distance()
{
    # Since we're using the same names found in the global scope, we can't change their values by accident
    # in this function. (less chance of "side-effects")
    local seq1="${1}"
    local seq2="${2}"

    local -i index="-1"
    local pos1
    local pos2
    local output=""
    local -i result=0

    # Walk the letters of the first string and compare them to the second string.
    for (( index=0; index < ${#seq1}; index++ )); do
        pos1="${seq1:${index}:1}"
        pos2="${seq2:${index}:1}"

        eprintf "[%s] == [%s]\n" "${pos1}" "${pos2}"

        if [[ ${pos1} == "${pos2}" ]]; then
            output+=" "
        else
            output+="^"
            (( result++ ))
        fi
    done

    eprintf "\n"
    eprintf "%s\n" "${seq1}" "${seq2}" "${output}"
    eprintf "\nHamming Distance: "
    printf "%d\n" "${result}"
}

calculate_hamming_distance "${seq1}" "${seq2}"