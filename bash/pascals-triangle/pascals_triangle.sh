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
    local rows="${1}"

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # One arguments?
    if [[ ${#vargs[@]} -ne 1 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # First argument: Number >=1?
    elif [[ ! ${rows} =~ ^[0-9]+$ ]] && [[ ${rows} -lt 1 ]]; then
        eprintf "ERROR: rows [%s] can only be a positive number that is >= 1.\n" "${rows}"
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
        printf "%s\n\n" "Compute Pascal's triangle up to a given number of rows."
        printf "Usage: %s rows" "$0"
        printf "\n"
    } >&2
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: Returns the value of a position in Pascal's triangle.
# Input : row (int), term (int)
# Output: int via reference
# Return: 0
n_choose_k()
{
    local -i row="${1}"
    local -i term="${2}"
    local -n __result="${3}"

    local -i __fact_row
    local -i __fact_term1
    local -i __fact_term2

    _factorial()
    {
        local -i n="${1}"
        local -n __f="${2}"

        local -i i

        __f="1"
        for (( i=2; i<=n; i++ )); do
            __f="${__f} * ${i}"
        done

        eprintf "%d! = %d\n" "${__f}"
    } # _factorial()

    _factorial "${row}" "__fact_row"
    _factorial "${term}" "__fact_term1"
    _factorial "$(( row - term ))" "__fact_term2"

    __result="${__fact_row} / (${__fact_term1} * ${__fact_term2})"
} # n_choose_k()

# Function: Draw Pascal's Triangle
# Input : rows to output
# Output: text represantation of Pascal's Triangle
# Return: 0
draw_pascals_triangle()
{
    local -i rows="${1}"

    local -i row
    local -i term
    local -i cell
    local -i offset

    ${DEBUG} && for (( row=0; row < rows; row++ )); do
        eprintf "[row=%d]\n\n" "${row}"

        offset="${rows} - ${row} - 1"
        eprintf "line offset = %d\n\n" "${offset}"

        for (( term=0; term <= row; term++ )); do
            n_choose_k "${row}" "${term}" "cell"
            eprintf "n(%d) choose k(%d) = %d\n\n" "${row}" "${term}" "${cell}"
        done

        eprintf "\n"
    done

    # Turn debug off so eprintf() doesn't ruin the triangle.
    DEBUG=false

    for (( row=0; row < rows; row++ )); do
        offset="${rows} - ${row} - 1"
        if [[ ${offset} -gt 0 ]]; then
            printf "%.0s " $(seq 1 "${offset}")
        fi

        for (( term=0; term <= row; term++ )); do
            n_choose_k "${row}" "${term}" "cell"
            printf "%d" "${cell}"

            if (( term == row )); then
                printf "\n"
            else
                printf " "
            fi
        done
    done
} # draw_pascals_triangle()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local -i rows="${1}"

    draw_pascals_triangle "${rows}"
} # main()

# Run the main function.
main "${@}"
