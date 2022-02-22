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

# https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
#
# Function: "This algorithm produces all primes not greater than n.
#  It includes a common optimization, which is to start enumerating the
#  multiples of each prime i from i2. The time complexity of this algorithm is
#  O(n log log n), provided the array update is an O(1) operation, as is
#  usually the case."
# Input : number greather than or equals to 2
# Output: returns prime array via reference
# Return: 0
# Time  : 18 seconds for 10,001th prime
find_primes_soe()
{
    local -i upper_limit="${1}"
    local -n __primes3="${2}"

    local -i outer
    local -i inner
    local -A -i sequence
    local -i sqrt_limit
    local -i loop
    local -i square

    eprintf "Using Sieve of Eratosthenes algorithim.\n"

    outer=2
    # for 10,001 x 11 -> takes 8s
    while [[ ${outer} -le "${upper_limit}" ]]; do
        sequence[$(( outer++ ))]=0  # true
    done

    outer=2
    sqrt_limit="$(bc <<< "scale=4; n=sqrt(${upper_limit}); scale=0; n/1 + 1")"

    # for 10,001 x 11 -> takes 12s
    while [[ ${outer} -le "${sqrt_limit}" ]]; do

        if [[ ${sequence[${outer}]:-1} -eq 0 ]]; then

            loop=2
            square="${outer} * ${outer}"  # faster to only square once per outer loop
            inner="${square} + (${outer} * (${loop} - 2))"

            while [[ ${inner} -le "${upper_limit}" ]]; do

                # it was faster to unset them and use "1" as the default value
                #sequence["${inner}"]=1  # false
                unset "sequence[${inner}]"

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
} # find_primes_soe()

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
    # could also use smaller search sizes for the other test smaller cases
    (( search_size *= 11 ))

    while [[ ${#primes[@]} -lt "${input}" ]]; do
        (( search_loops++ ))

        eprintf "Search loop [%d], # of primes [%d]\n\n" "${search_loops}" "${#primes[@]}"

        # read -r -d "\n" -a primes < <(find_primes_soe_1 "${search_size}" "${n}")
        find_primes_soe "${search_size}" "primes"

        # 3rd optimization: only return the last element
        __prime="${primes[$(( n - 1 ))]}"

        # double the previous search size
        (( search_size *= 2 ))
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
