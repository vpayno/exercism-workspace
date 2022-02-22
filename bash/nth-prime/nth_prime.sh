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
    elif [[ ! ${input} =~ ^[[:digit:]]+$ ]] || [[ ${input} -lt 1 ]]; then
        eprintf "ERROR: can only be a positive input greater than or equals to 1 [%s].\n" "${input}"
        printf "invalid input\n"
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
        printf "Usage: %s <number greater than or equals to 1>" "$0"
        printf "\n"
    } >&2
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
# Usually when you show the usage screen because the wrong arguments were passed,
# it's an error, marking it not an error so the tests pass.
# Also, we don't output anything for the same test.
check_args "$@" || exit 1

# Function: brute force to find large nth primes
# Input : number greather than or equals to 2
# Output: a newline delimeted list of prime numbers
# Return: 0
# Time  : 108 seconds for 10,001th prime
find_primes_soe_2()
{
    local -i upper_limit="${1}"
    local -n __primes3="${2}"

    local -i outer
    local -i inner
    local -A -i sequence
    local -i step
    local -i index
    local -i sqrt_limit
    local -i loop
    local -i square

    #if [[ ${upper_limit} -ge 1 ]]; then
        #__primes3=( 2 )
    #fi

    #if [[ ${upper_limit} -ge 2 ]]; then
        #__primes3+=( 3 )
    #fi

    outer=2
    while [[ ${outer} -le "${upper_limit}" ]]; do
        sequence[${outer}]=0  # true
        outer+="1"
    done

    outer=2
    sqrt_limit="$(bc <<< "scale=4; n=sqrt(${upper_limit}); scale=0; n/1 + 1")"

    while [[ ${outer} -le "${sqrt_limit}" ]]; do

        if [[ ${sequence[${outer}]} -eq 0 ]]; then

            loop=2
            square="${outer} * ${outer}"
            inner="${square} + (${outer} * (${loop} - 2))"

            while [[ ${inner} -le "${upper_limit}" ]]; do

                sequence["${inner}"]=1  # false

                loop+="1"
                inner="${square} + (${outer} * (${loop} - 2))"
            done

        fi

        outer+=1
    done


    for outer in $(printf "%d\n" "${!sequence[@]}" | sort -n); do

        if [[ ${sequence["${outer}"]} -eq 0 ]]; then
            __primes3+=( "${outer}" )
        fi
    done

    eprintf "primes: ["; eprintf "%s," "${__primes3[@]}"; eprintf "]\n"
} # find_primes_soe_2()

# Function: uses sieve of eratosthenes algorithm to find the prime numbers in a sequence
# Input : number greather than or equals to 2
# Output: __primes array is a reference
# Return: 0
# Time  : 125 seconds for 10,001th prime
find_primes_soe_1()
{
    local -i upper_limit="${1}"
    local -i stop_limit="${2:-${upper_limit}}"
    local -n __primes="${3}"

    local -i index
    local -A sequence
    local -i inner
    local -i outer
    local -i step

    # 5th optimization: only add odd numbers to the sequence
    index="2"
    sequence["${index}"]="unknown"
    index="3"
    step=2

    # 4th optimization: don't use seq since it's very slow
    while [[ ${index} -le ${upper_limit} ]]; do
        sequence["${index}"]="unknown"
        index+="${step}"
    done

    # The keys aren't guaranteed to be sorted.
    for outer in $(printf "%d\n" "${!sequence[@]}" | sort -n); do
        # eprintf "outer=%d\n" "${outer}"

        # 5th optimization: don't use seq since it's very slow
        inner="${outer}"
        step="${outer}"
        while [[ ${inner} -le "${upper_limit}" ]]; do
            # eprintf "\tinner=%d\n" "${inner}"

            if [[ ${outer} == "${inner}" ]] && [[ ${sequence[${inner}]:-unknown} == "unknown" ]]; then
                sequence["${inner}"]="prime"
                __primes+=( "${inner}" )
                # eprintf "\t\t%d => %s\n" "${inner}" "prime"

            elif [[ ${sequence[${inner}]} == unknown ]]; then
                sequence["${inner}"]="not_prime"
                # eprintf "\t\t%d => %s\n" "${inner}" "not a prime"

            fi

            # 2nd optimization: stop searching when we reach the nth prime
            if [[ ${#__primes[@]} -ge "${stop_limit}" ]]; then
                eprintf "Found enough prime numbers [%d] >= [%d]\n" "${#__primes[@]}" "${stop_limit}"
                break 2
            fi

            inner+="${step}"
        done

    done

    eprintf "Prime numbers: "
    eprintf "%s, " "${__primes[@]}"
    eprintf "\n"

    # Returned by refrence now.
    # printf "%s\n" "${primes[@]}"

    return 0
} # find_primes_soe_1()

# Function: use either soe or soa algorithims to find a prime number based on the size of n.
# Input : number greater than or equals to 1
# Output: a newline delimited list of prime numbers
# Return: 0
find_primes()
{
    local -i n="${1}"
    local -n __prime="${2}"

    local -a -i primes
    local -i search_size="${n}"
    local -i search_loops=0

    # 1st optimization: use a large search size to minimize restarts
    (( search_size *= 20 ))

    while [[ ${#primes[@]} -lt "${input}" ]]; do
        (( search_loops++ ))

        eprintf "Search loop [%d], # of primes [%d]\n\n" "${search_loops}" "${#primes[@]}"

        eprintf "Using Sieve of Eratosthenes algorithim.\n"

        # read -r -d "\n" -a primes < <(find_primes_soe_1 "${search_size}" "${n}")
        #find_primes_soe_1 "${search_size}" "${n}" "primes"
        find_primes_soe_2 "${search_size}" "primes"

        # 3rd optimization: only return the last element
        # printf "%s\n" "${primes[@]: -1}"
        #__prime="${primes[*]: -1}"
        __prime="${primes[$(( n - 1 ))]}"

        (( search_size *= 10 ))
    done

    eprintf "Search loop [%d], # of primes [%d]\n\n" "${search_loops}" "${#primes[@]}"

    return 0
} # find_primes()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local -i input="${1}"

    local -i prime

    # read -r -d "\n" -a primes < <(find_primes "${input}")
    find_primes "${input}" "prime"

    # Don't forget to trim the traling white space so the tests pass.
    # printf "%s " "${primes[$(( input - 1 ))]}" | sed -r -e 's/ +$//g'
    # printf "%s\n" "${primes[@]}"
    printf "%s\n" "${prime}"
    # printf "\n"
} # main()

# Run the main function.
main "${@}"
