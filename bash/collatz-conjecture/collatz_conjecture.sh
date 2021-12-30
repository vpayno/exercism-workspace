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
    local number="${1}"

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # One argument?
    if [[ ${#vargs[@]} -ne 1 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # Number == 0?
    elif [[ ${number} -le 0 ]]; then
        eprintf "ERROR: the argument [%s] can only be a positive number.\n" "${number}"
        printf "%s\n" "Error: Only positive numbers are allowed"
        #show_usage
        (( retval++ ))


    # Number?
    elif [[ ! ${number} =~ ^[[:digit:]]+$ ]]; then
        eprintf "ERROR: the argument [%s] can only be a positive number.\n" "${number}"
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
        printf "%s\n\n" "Using the Collatz Conjecture, return the number of steps required to reach 1."
        printf "Usage: %s number" "$0"
        printf "\n"
    } >&2
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: Use the Collatz Conjecture for n and count the steps to get to 1.
# Input : number
# Output: number
# Return: 0
collatz_steps()
{
    local -i number="${1}"

    local -i n
    local -i step

    n="${number}"
    eprintf "Step [%d]: n = %d\n" "${step}" "${n}"

    while (( n > 1 )); do
        if (( n % 2 == 0 )); then
            n="${n} / 2"
        else
            n="${n} * 3 + 1"
        fi

        (( step++ ))

        eprintf "Step [%d]: n = %d\n" "${step}" "${n}"
    done

    printf "%d" "${step}"
} # collatz_steps()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local -i input="${1}"

    local -i output

    output="$(collatz_steps "${input}")"

    eprintf "Number: [%d]\n" "${input}"
    eprintf " Steps: [%d]\n" "${output}"
    ${DEBUG} || printf "%s\n" "${output}"
} # main()

# Run the main function.
main "${@}"
