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

    # Two arguments?
    if [[ ${#vargs[@]} -gt 1 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # First argument: Either encode or decode?
    elif [[ ! ${number} =~ ^[[:digit:]]+$ ]]; then
        eprintf "ERROR: input [%s] can only an integer.\n" "${number}"
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
    printf "Usage: %s \"<string>\"" "$0"
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

# Function: Returns the prime factors for a given number.
# Input : An integer.
# Output: A space separated list of prime factors.
# Return: 0
prime_factors()
{
    local -i number="${1}"

    local factor
    local -a result

    _prime_factors()
    {
        #eprintf "Testing factor %d.\n" "${factor}"

        while (( number % factor == 0 )) && (( number > 1 )); do
            eprintf "%d is divisible by %d\n" "${number}" "${factor}"
            (( number /= factor ))
            result+=( "${factor}" )
        done
    } # _prime_factors()

    # We need to use the coproc to generate numbers for really large sequences.
    # (lazy generation) - but if we don't use it for a large enough number it
    # won't work since it runs really fast (sleeps don't help).
    if [[ ${number} -gt 9999 ]]; then
        # seq takes forever on really large numbers so let's use coproc
        coproc coproc_seq (
            local -i next=3
            local -i end="${number}"

            # Except for 2, the rest of the prime numbers are odd.
            # So just print 2 and then only print odd numbers. This shaves at
            # least 10 seconds from the tests.
            printf "%d\n" 2

            while [[ ${next} -le ${end} ]]; do
                printf "%d\n" "${next}"
                (( next+=2 ))
            done
        )

        while read -r factor <& "${coproc_seq[0]}" &>/dev/null && (( number > 1 )); do
            _prime_factors
        done
    else
        for factor in $(seq 2 "${number}"); do
            _prime_factors
            (( number == 1 )) && break
        done
    fi

    printf "%s" "${result[*]}"
} # prime_factors()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local -i number="${1}"

    local factors

    factors="$(prime_factors "${number}")"

    eprintf "Prime factors of %d: [%s]\n" "${number}" "${factors}"
    ${DEBUG} || printf "%s\n" "${factors}"
} # main()

# Run the main function.
main "${@}"
