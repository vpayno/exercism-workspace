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
    local planet="${1^}"  # titlecase the string
    local seconds="${2}"

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # Two arguments?
    if [[ ${#vargs[@]} -ne 2 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # First argument: A planet?
    elif [[ ! ${planet} =~ ^(Mercury|Venus|Earth|Mars|Jupiter|Saturn|Uranus|Neptune)$ ]]; then
        eprintf "ERROR: [%s] is not a planet.\n" "${planet}"
        #show_usage
        printf "%s\n" "not a planet"
        (( retval++ ))

    # Second argument: seconds?
    elif [[ ! ${seconds} =~ ^[0-9]+$ ]]; then
        eprintf "ERROR: [%s] is not a positive integer.\n" "${planet}"
        #show_usage
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
        printf "%s\n\n" "Given an age in seconds, calculate how old someone would be on other planets."
        printf "Usage: %s \"Mercury|Venus|Earth|Mars|Jupiter|Saturn|Uranus|Neptune\" seconds" "$0"
        printf "\n"
    } >&2
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: Calculates your space age.
# Input : integer (seconds)
# Output: integer (Earth years)
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

# Function: Calculates space age relative to Earth.
# Input : planet, seconds
# Output: Earth years
# Return: 0
calculate_spage_age()
{
    local planet="${1^}"
    local -i seconds="${2}"

    local output
    local -A planets=(
        ["Mercury"]="0.2408467"
        ["Venus"]="0.61519726"
        ["Earth"]="1.0"
        ["Mars"]="1.8808158"
        ["Jupiter"]="11.862615"
        ["Saturn"]="29.447498"
        ["Uranus"]="84.016846"
        ["Neptune"]="164.79132"
    )

    output="$(bc <<< "scale=3; (${seconds} / (${planets[${planet}]} * 31557600))")"

    # The tests expect you to round with printf. bc truncates.
    printf "%.2f" "${output}"
} # calculate_spage_age()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local planet="${1,,}"
    local -i seconds="${2}"

    local output

    planet="$(trim "${planet}")"

    eprintf "   Planet: [%s]\n" "${planet^}"
    eprintf "  Seconds: [%d]\n" "${seconds}"

    output="$(calculate_spage_age "${planet}" "${seconds}")"

    eprintf "Earth Age: [%s years] \n" "${output}"
    ${DEBUG} || printf "%s\n" "${output}"
} # main()

# Run the main function.
main "${@}"
