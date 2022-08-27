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

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # One or more arguments?
    if [[ ${#vargs[@]} -lt 1 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        #show_usage
        (( retval++ ))

    elif [[ ! "${vargs[*]}" =~ ^([0-9]| )+$ ]]; then
        eprintf "ERROR: arguments [%s] can only be integers.\n" "${vargs[*]:1}"
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
    printf "Usage: %s number <one or more integers who's multiple to sum>" "$0"
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

# Function: Sum the multiples of a number.
# Input : number, multiples to search for
# Output: sum of the multiples
# Return: 0
sum_of_multiples()
{
    local -i number="${1}"
    shift 1
    local -a -i multiples=( 0 "$@" )

    local -i multiple
    local -i sum=0
    local -i i j

    # We're using the keys as a set. The value of each
    local -A -i multiples_set

    # Remove duplicates in the multiples.
    # shellcheck disable=SC2046
    mapfile -t multiples< <(printf "%d\n" $(printf "%s\n" "${multiples[@]}" | sort -un))

    eprintf "multiples after deduping: %s\n" "${multiples[*]}"

    for i in $(seq 0 $(( ${#multiples[@]} - 1 ))); do
        # Remove zeros and ones from the multiple list.
        if [[ ${multiples[${i}]} -eq 0 ]]; then
            eprintf "Removing zero at position %d\n" "${i}"
            unset "multiples[${i}]"
            continue
        fi
    done

    # Remove multiples of multiples. Using the keys of an assosiative array as
    # a faux set.
    for i in "${multiples[@]}"; do
        for j in "${multiples[@]}"; do

            if [[ ${i} -eq ${j} ]]; then
                continue
            fi

            if (( i * j <= number )); then
                multiples_set[$(( i * j ))]=1
            fi
        done
    done

    for i in $(seq 1 $(( number - 1 ))); do
        for j in "${multiples[@]}"; do
            if (( i % j == 0)) && (( i <= number )); then
                multiples_set[${i}]=1
            fi
        done
    done

    eprintf "multiples after clean up: %s\n" "${multiples[*]}"
    eprintf "\n"

    # Create a new multiples array.
    eprintf "multiples_set: %s\n" "${!multiples_set[*]}"
    eprintf "\n"

    for multiple in "${!multiples_set[@]}"; do
        (( sum += multiple ))
    done
    eprintf "sum = %d\n" "${sum}"

    printf "%d" "${sum}"
} # sum_of_multiples()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local -i number="${1}"
    shift 1
    local -a multiples=( "$@" )

    local -i sum=0

    eprintf "Number   : [%s]\n" "${number}"
    eprintf "Multiples: [%s]\n" "${multiples[*]}"

    sum="$(sum_of_multiples "${number}" "${multiples[@]}")"

    ${DEBUG} || printf "%d\n" "${sum}"
} # main()

# Run the main function.
main "${@}"
