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

    # Only positive whole numbers?
    elif [[ ! ${number} =~ ^[0-9]+$ ]]; then
        eprintf "ERROR: Only positive while numbers.\n" "${number}"
        #show_usage
        printf "%s\n" "Classification is only possible for natural numbers."
        (( retval++ ))

    # Numbers greather than 0?
    elif [[ ${number} -lt 1 ]]; then
        eprintf "ERROR: Only positive while numbers.\n" "${number}"
        #show_usage
        printf "%s\n" "Classification is only possible for natural numbers."
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
        printf "%s\n\n" "Determine if a number is perfect, abundant, or deficient based on Nicomachus' (60 - 120 CE) classification scheme for positive integers."
        printf "Usage: %s number" "$0"
        printf "\n"
    } >&2
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: Returns the prime factors for a given number.
# Input : An integer.
# Output: A space separated list of prime factors.
# Return: 0
find_factors()
{
    local -i number="${1}"

    local -i factor
    local -i register
    local -a result
    local -i stop

    # Don't use seq to generate factors, instead use a while loop. It's a lot faster.

    #(( stop = number / 2 ))
    stop="$(bc <<< "scale=0; sqrt(${number})/1")"

    # No need to calculate these.
    result+=( 1 "${number}" )

    factor=2
    while (( factor <= stop )); do
        register="${number}"

        #if (( number % factor == 0 )) && (( register > 1 )); then
        if (( number % factor == 0 )); then
            (( register = number / factor ))

            result+=( "${register}" "${factor}" )
        fi

        [[ ${number} -eq ${factor} ]] && break
        (( factor += 1 ))
    done

    # Sort and dedup the list.
    mapfile -t result < <(sort -un < <(printf "%s\n" "${result[@]}"))

    eprintf "\n"

    printf "%s\n" "${result[@]}"
} # find_factors()

# Function: Is the number perfect, abundant or deficient?
# Input : number
# Output: perfect, abundant or deficient
# Return: 0
nicomachus()
{
    local -i number="${1}"

    local result
    local -a -i factors
    local -i total
    local -i sum

    mapfile -t factors < <(find_factors "${number}")

    eprintf "factors: %s\n" "${factors[*]}"

    total="${factors[*]: -1}"
    eprintf "sum eq: %s\n" "$(paste -sd+ < <(printf "%s\n" "${factors[@]::${#factors[@]}-1}"))"
    sum="$(bc < <(paste -sd+ < <(printf "%s\n" "${factors[@]::${#factors[@]}-1}")))"

    eprintf "number: %d\n" "${number}"
    eprintf "   sum: %d\n" "${sum}"

    if [[ ${total} -eq ${sum} ]]; then
        result="perfect"
    elif [[ ${total} -lt ${sum} ]]; then
        result="abundant"
    elif [[ ${total} -gt ${sum} ]]; then
        result="deficient"
    fi

    printf "%s" "${result}"
} # nicomachus()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local number="${1}"

    local output_text

    output_text="$(nicomachus "${number}")"

    eprintf "[%s]\n" "${output_text}"
    ${DEBUG} || printf "%s\n" "${output_text}"
} # main()

# Run the main function.
main "${@}"
