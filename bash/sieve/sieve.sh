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
    local input="${1}"

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # One argument?
    if [[ ${#vargs[@]} -ne 1 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        #show_usage
        (( retval++ ))

    # First argument: A number?
    elif [[ ! ${input} =~ ^[[:digit:]]+$ ]] || [[ ${input} -lt 2 ]]; then
        eprintf "ERROR: can only be a positive input greater than or equals to 2 [%s].\n" "${input}"
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
        printf "\n%s\n\n" "Given a number n, determine what the nth prime is."
        printf "Usage: %s <number greater than or equals to 2>" "$0"
        printf "\n"
    } >&2
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
# Usually when you show the usage screen because the wrong arguments were passed,
# it's an error, marking it not an error so the tests pass.
# Also, we don't output anything for the same test.
check_args "$@" || exit 0

# Function: uses seive of eratosthenes algorithm to find the prime numbers in a sequence
# Input : number greater than or equals to 2
# Output: a newline delimeted list of prime numbers
# Return: 0
find_primes()
{
    local -i upper_limit="${1}"
    local -n __primes="${2}"

    local -i index
    local -A sequence
    local -i inner
    local -i outer
    local -i step

    # 1st optimization: only add odd numbers to the sequence
    index="2"
    sequence["${index}"]="unknown"
    index="3"
    step=2

    # 2nd optimization: don't use seq since it's very slow
    while [[ ${index} -le ${upper_limit} ]]; do
        sequence["${index}"]="unknown"
        index+="${step}"
    done

    # The keys aren't guaranteed to be sorted.
    for outer in $(printf "%d\n" "${!sequence[@]}" | sort -n); do
        eprintf "outer=%d\n" "${outer}"

        # 2nd optimization: don't use seq since it's very slow
        inner="${outer}"
        step="${outer}"
        while [[ ${inner} -le "${upper_limit}" ]]; do
            # eprintf "\tinner=%d\n" "${inner}"

            if [[ ${outer} == "${inner}" ]] && [[ ${sequence[${inner}]} == "unknown" ]]; then
                sequence["${inner}"]="prime"
                __primes+=( "${inner}" )
                eprintf "\t\t%d => %s\n" "${inner}" "prime"

            elif [[ ${sequence[${inner}]} == unknown ]]; then
                sequence["${inner}"]="not_prime"
                # eprintf "\t\t%d => %s\n" "${inner}" "not a prime"

            fi

            inner+="${step}"
        done
    done

    eprintf "Prime numbers: "
    eprintf "%s, " "${__primes[@]}"
    eprintf "\n"

    # This is now returned by reference.
    # printf "%s\n" "${__primes[@]}"

    return 0
} # find_primes()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local -i input="${1}"

    local -a -i primes

    #read -r -d "\n" -a primes < <(find_primes "${input}")
    find_primes "${input}" "primes"

    # Don't forget to trim the traling white space so the tests pass.
    printf "%s " "${primes[@]}" | sed -r -e 's/ +$//g'
    printf "\n"
} # main()

# Run the main function.
main "${@}"
