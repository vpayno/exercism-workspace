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

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # Was a single argument passed?
    if [[ ${#vargs[@]} -ne 1 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
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
# Input : a multi-token string
# Output: the acronym of the input
# Return: 0 (success) or >=1 (error)
main()
{
    # Convert underscores and dashes to spaces. It will make tokenizing the string easier.
    # The order matters in the regex when you have special characters like dashes, asterisk, etc.
    local input="${1//[*?_-]/ }"

    local -a words
    local word
    local output=""

    # Tokenize the string into an array. At the same time uppercase the tokens.
    read -r -a words <<< "${input^^}"

    # Walk the words array and grab the first letter from each word.
    for word in "${words[@]}"; do
        output+="${word:0:1}"
    done

    eprintf "\nInput: %s\n" "${input}"
    eprintf "\nAcronym: "
    printf "%s\n" "${output}"
}

# Run the main function.
main "${@}"
