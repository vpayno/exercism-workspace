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
    local command="${2,,}"  # lowercase the string
    local allergy="${3,,}"  # lowercase the string

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # Two or Three arguments?
    if [[ ${#vargs[@]} -lt 1 ]] || [[ ${#vargs[@]} -gt 3 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # Second argument: Either list or allergic_to?
    elif [[ ! ${command} =~ ^(list|allergic_to)$ ]]; then
        eprintf "ERROR: command [%s] can either be list or allergic_to.\n" "${command}"
        show_usage
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
    printf "Usage:\n"
    printf "\t%s allergy_score list" "$0"
    printf "\t%s allergy_score allergic_to (cats|pollen|chocolate|tomatoes|strawberries|shellfish|peanuts|eggs)" "$0"
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

# Function: Check the passed allergy score.
# Input : score, command, optional argument
# Output: exercise output
# Return: 0
check_allergy_score()
{
    local -i score="${1}"
    local command="${2,,}"
    local allergy_test="${3,,}"

    local allergy
    local output_list
    local output_text

    # manually track order of the allergies associative array since they don't keep insertion order.
    local -a order=( cats pollen chocolate tomatoes strawberries shellfish peanuts eggs )

    local -A allergies=(
        [cats]=128
        [pollen]=64
        [chocolate]=32
        [tomatoes]=16
        [strawberries]=8
        [shellfish]=4
        [peanuts]=2
        [eggs]=1
    )

    local -A results=(
        [cats]=false
        [pollen]=false
        [chocolate]=false
        [tomatoes]=false
        [strawberries]=false
        [shellfish]=false
        [peanuts]=false
        [eggs]=false
    )

    # Ignore allergies with scores higher than 128.
    if [[ ${score} -ge 256 ]]; then
        (( score%=256 ))
    fi

    for allergy in "${order[@]}"; do
        eprintf "Testing for %s allergy: " "${allergy}"
        if (( score - ${allergies[${allergy}]} >= 0 )) ; then
            output_list="${allergy} ${output_list}"
            (( score -= ${allergies[${allergy}]} ))
            eprintf "%s\n" "true"
            results["${allergy}"]="true"
        else
            eprintf "%s\n" "false"
        fi
    done

    output_list="$(trim "${output_list}")"
    eprintf "allergy list: %s\n" "${output_list}"

    eprintf "\n"
    ${DEBUG} && declare -p -A allergies > /dev/stderr
    eprintf "\n"
    ${DEBUG} && declare -p -A results > /dev/stderr
    eprintf "\n"

    case ${command} in
        list)
            printf "%s\n" "${output_list}"
            ;;
        allergic_to)
            eprintf "Allergic to [%s] -> %s\n" "${allergy_test}" "${results[${allergy_test}]}"
            printf "%s\n" "${results[${allergy_test}]}"
            ;;
    esac
} # check_allergy_score()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local -i score="${1}"
    local command="${2,,}"
    local allergy="${3,,}"

    if [[ $# -eq 3 ]]; then
        eprintf "arguments: [%d] [%s] [%s]\n" "${score}" "${command}" "${allergy}"
    else
        eprintf "arguments: [%d] [%s]\n" "${score}" "${command}"
    fi

    output_text="$(check_allergy_score "${score}" "${command}" "${allergy}")"

    eprintf "[%s]\n" "${output_text}"
    ${DEBUG} || printf "%s\n" "${output_text}"
} # main()

# Run the main function.
main "${@}"
