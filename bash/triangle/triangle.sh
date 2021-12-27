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
    local name="${1,,}"  # lowercase the string
    local length1="${2}"
    local length2="${3}"
    local length3="${4}"

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # Four arguments?
    if [[ ${#vargs[@]} -ne 4 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # First argument: Triangle name.
    elif [[ ! ${name} =~ ^(equilateral|isosceles|scalene)$ ]]; then
        eprintf "ERROR: name [%s] can be one of (equilateral|isosceles|scalen).\n" "${name}"
        show_usage
        (( retval++ ))

    # Length arguments: Are they numbers?
    elif [[ ! "${length1}${length2}${length3}" =~ ^[.0-9]+$ ]]; then
        eprintf "ERROR: the lengths [%d], [%d], [%d] can be integers or floats.\n" "${length1}" "${length2}" "${length3}"
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
        printf "%s\n" "Determinte if a triangle is equilateral, isosceles, or scalene."
        printf "Usage: %s \"(equilateral|isosceles|scalene)\" length1 length2 length3" "$0"
        printf "\n"
    } >&2
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: Test to see if triangle is equilateral.
# Input : length1, length2, length3
# Output: (none)
# Return: 0 (true) or 1 (false)
is_equilateral()
{
    local -a lengths=( "${@}" ) # don't use -i

    if [[ $(bc <<< "${lengths[0]} == ${lengths[1]}") -eq 1 ]] &&
        [[ $(bc <<< "${lengths[0]} == ${lengths[2]}") -eq 1 ]]; then
        return 0
    else
        return 1
    fi
} # is_equilateral()

# Function: Test to see if triangle is isosceles.
# Input : length1, length2, length3
# Output: (none)
# Return: 0 (true) or 1 (false)
is_isosceles()
{
    local -a lengths=( "${@}" ) # don't use -i

    if [[ $(bc <<< "${lengths[0]} == ${lengths[1]}") -eq 1 ]] ||
        [[ $(bc <<< "${lengths[1]} == ${lengths[2]}") -eq 1 ]] ||
        [[ $(bc <<< "${lengths[2]} == ${lengths[0]}") -eq 1 ]]; then
        return 0
    else
        return 1
    fi
} # is_isosceles()

# Function: Test to see if triangle is scalen.
# Input : length1, length2, length3
# Output: (none)
# Return: 0 (true) or 1 (false)
is_scalene()
{
    local -a lengths=( "${@}" ) # don't use -i

    if [[ $(bc <<< "${lengths[0]} != ${lengths[1]}") -eq 1 ]] &&
        [[ $(bc <<< "${lengths[1]} != ${lengths[2]}") -eq 1 ]] &&
        [[ $(bc <<< "${lengths[2]} != ${lengths[0]}") -eq 1 ]]; then
        return 0
    else
        return 1
    fi
} # is_scalene()

# Function: Test to see if the lengths form a triangle.
# Input : length1, length2, length3
# Output: (none)
# Return: 0 (true) or 1 (false)
is_triangle()
{
    local -a lengths=( "${@}" ) # don't use -i

    eprintf "is_triangle? "
    if [[ $(bc <<< "${lengths[0]} > 0") -eq 1 ]] &&
        [[ $(bc <<< "${lengths[1]} > 0") -eq 1 ]] &&
        [[ $(bc <<< "${lengths[2]} > 0") -eq 1 ]]; then
        eprintf "no 0 sides, "
        if [[ $(bc <<< "${lengths[0]} + ${lengths[1]} >= ${lengths[2]}") -eq 1 ]] &&
            [[ $(bc <<< "${lengths[1]} + ${lengths[2]} >= ${lengths[0]}") -eq 1 ]] &&
            [[ $(bc <<< "${lengths[2]} + ${lengths[0]} >= ${lengths[1]}") -eq 1 ]]; then
            eprintf "a + b >= c: yes\n"
            return 0
        else
            eprintf "a + b < c: no\n"
            return 1
        fi
    else
        eprintf "at least 1 side equals 0: no\n"
        return 1
    fi
} # is_triangle()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local name="${1,,}"
    shift
    local -a lengths=( "${@}" ) # don't use -i

    eprintf "Is triangle with lengths [%s] an [%s] triangle? " "${lengths[*]}" "${name}"

    if ! is_triangle "${lengths[@]}"; then
        printf "%s\n" "false"
        return 0
    fi

    case "${name}" in
        equilateral)
            if is_equilateral "${lengths[@]}"; then
                printf "%s\n" "true"
            else
                printf "%s\n" "false"
            fi
            ;;
        isosceles)
            if is_isosceles "${lengths[@]}"; then
                printf "%s\n" "true"
            else
                printf "%s\n" "false"
            fi
            ;;
        scalene)
            if is_scalene "${lengths[@]}"; then
                printf "%s\n" "true"
            else
                printf "%s\n" "false"
            fi
            ;;
    esac
} # main()

# Run the main function.
main "${@}"
