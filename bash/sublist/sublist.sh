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
    local list1="${1}"
    local list2="${2}"

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # Two arguments?
    if [[ ${#vargs[@]} -ne 2 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # Is it a properly formatted list?
    elif [[ ! ${list1} =~ ^\[(|([0-9]+, )+([0-9]+)|[[0-9]+)]$ ]]; then
        eprintf "ERROR: The first list \"%s\" isn't properly formatted.\n" "${list1}"
        show_usage
        (( retval++ ))


    # Is it a properly formatted list?
    elif [[ ! ${list2} =~ ^\[(|([0-9]+, )+([0-9]+)|[[0-9]+)]$ ]]; then
        eprintf "ERROR: The second list \"%s\" isn't properly formatted.\n" "${list2}"
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
    {
        printf "%s\n\n" "Determine the relationship between two lists."
        printf "Usage: %s \"[1, 2, 3, ...]\" \"[2, 3, 4, ...]\"" "$0"
        printf "\n"
    } >&2
} # show_usage()

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
} # trim()

# Function: Determine the releationship between two lists.
# Input : Two numeric lists.
# Output: One of (equal|sublist|superlist|unequal).
# Return: 0
compare_lists()
{
    local -a -i list1
    local -a -i list2

    read -r -a list1 <<< "$1"
    read -r -a list2 <<< "$2"

    local result

    # [] == []
    if [[ ${#list1[@]} -eq 0 ]] && [[ ${#list2[@]} -eq 0 ]]; then
        result="equal"

    # [...] == [...]
    elif [[ ${#list1[@]} -eq ${#list2[@]} ]]; then

        # [1, 2, 3] == [1, 2, 3]
        if [[ ${list1[*]} == "${list2[*]}" ]]; then
            result="equal"
        else
            result="unequal"
        fi

    # [1, ...] >= []
    elif [[ ${#list1[@]} -gt ${#list2[@]} ]]; then

        # [1, 2, 3, 4, 5] >= [1, 2, 3]
        if [[ ${list1[*]} =~ ${list2[*]} ]]; then
            result="superlist"
        else
            result="unequal"
        fi

    # [] <= [1, ...]
    elif [[ ${#list1[@]} -lt ${#list2[@]} ]]; then

        # [1, 2, 3] <= [1, 2, 3, 4, 5]
        if [[ ${list2[*]} =~ ${list1[*]} ]]; then
            result="sublist"
        else
            result="unequal"
        fi
    fi

    printf "%s" "${result}"
} # compare_lists()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local input1="${1}"
    local input2="${2}"

    local result

    local -a -i list1
    local -a -i list2

    eprintf "list1: %s\n" "${input1}"
    eprintf "list2: %s\n" "${input2}"
    eprintf "\n"

    read -r -a list1 < <(tr -d '][,' <<< "${input1}")
    read -r -a list2 < <(tr -d '][,' <<< "${input2}")

    result="$(compare_lists "${list1[*]}" "${list2[*]}")"

    eprintf "[%s]\n" "${result}"
    ${DEBUG} || printf "%s\n" "${result}"
} # main()

# Run the main function.
main "${@}"
