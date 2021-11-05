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

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # If there is no input, there will be silence (one of the tests).
    # This breaks one of the tests that expects a response when nothing is spoken to Bob.
    #if [[ ${#vargs[@]} -eq 0 ]]; then
        #exit 0
    #fi

    # Was a single argument passed?
    # This breaks one of the tests that expects a response when nothing is spoken to Bob.
    # Change it to just test to see if we have too many arguments (forgot to quote the string?).
    if [[ ${#vargs[@]} -gt 1 ]]; then
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
}

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0 (success) or >=1 (error)
main()
{
    local input="${1}"

    local -A responses
    local response
    local trigger

    # Build a response assosiative array (dictionary).
    responses["catchall"]="Fine. Be that way!"
    responses["question"]="Sure."
    responses["statement"]="Whatever."
    responses["yelling"]="Whoa, chill out!"
    responses["yelling_question"]="Calm down, I know what I'm doing!"

    # Remove trailing white space.
    input="$(trim "${input}")"

    # Check the statement for clues on how we should respond.

    # Look for a question with only numbers.
    if [[ ${input} =~ ^([[:digit:]]|[[:punct:]]|[[:space:]]|\n|\r|\t)+\?[[:space:]]*$ ]]; then
        trigger="question"

    # Look for a statement with only numbers.
    elif [[ ${input} =~ ^([[:digit:]]|[[:punct:]]|[[:space:]]|\n|\r|\t)+[!.]?[[:space:]]*$ ]]; then
        trigger="statement"

    # Look for a question in all caps.
    elif [[ ${input} =~ ^([[:digit:]]|[[:upper:]]|[[:punct:]]|[[:space:]]|\n|\r|\t)+\?[[:space:]]*$ ]]; then
        trigger="yelling_question"

    # Look for a question.
    elif [[ ${input} =~ ^([[:digit:]]|[[:alpha:]]|[[:punct:]]|[[:space:]]|\n|\r|\t)+\?[[:space:]]*$ ]]; then
        trigger="question"

    # Look for a statement in all caps.
    elif [[ ${input} =~ ^([[:digit:]]|[[:upper:]]|[[:punct:]]|[[:space:]]|\n|\r|\t)+[!.]?[[:space:]]*$ ]]; then
        trigger="yelling"

    # Look for whitespace only.
    elif [[ ${input} =~ ^([[:space:]]|\n|\r|\t)*$ ]]; then
        trigger="catchall"

    # Look for a statement.
    elif [[ ${input} =~ ^([[:digit:]]|[[:alpha:]]|[[:punct:]]|[[:space:]]|\n|\r|\t)+[!.]?$ ]]; then
        trigger="statement"

    # Everything else.
    else
        trigger="catchall"
    fi

    response="${responses[${trigger}]}"

    eprintf "\n"
    eprintf "Input   : %s\n" "${input}"
    eprintf "\n"
    eprintf "Response: "
    printf "%s\n" "${response}"
}

# Run the main function.
main "${@}"
