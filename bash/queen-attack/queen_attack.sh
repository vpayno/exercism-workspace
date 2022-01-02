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
    local wqf="${1,,}"
    local wqxy="${2}"
    local bqf="${3,,}"
    local bqxy="${4}"

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # -w 2,2 -b 3,1
    # Four arguments?
    if [[ ${#vargs[@]} -ne 4 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # First argument: White Queen Flag
    elif [[ ${wqf} != -w ]]; then
        eprintf "ERROR: First argument [%s] isn't \"-w\".\n" "${wqf}"
        show_usage
        (( retval++ ))

    # Fourth argument: Black Queen x,y out of range
    elif [[ ${wqxy} =~ [8-9] ]]; then
        eprintf "ERROR: Second argument [%s] row/column not on board.\n" "${wqxy}"

        if [[ ! ${wqxy} =~ ^[0-7],[8-9]$ ]]; then
            eprintf "ERROR: Second argument [%s] row not on board.\n" "${wqxy}"
            printf "%s\n" "row not on board"
        elif [[ ! ${wqxy} =~ ^[8-9],[0-7]$ ]]; then
            eprintf "ERROR: Second argument [%s] column not on board.\n" "${wqxy}"
            printf "%s\n" "column not on board"
        fi

        show_usage
        (( retval++ ))

    # Second argument: White Queen x,y Negative Positions
    elif [[ ${wqxy} =~ ^(-[0-9],[0-9]|[0-9],-[0-9]|-[0-9],-[0-9])$ ]]; then
        eprintf "ERROR: Second argument [%s] can't contain negative numberts.\n" "${wqxy}"
        printf "%s\n" "row not positive OR column not positive"
        show_usage
        (( retval++ ))

    # Equal positions
    elif [[ ${wqxy} == "${bqxy}" ]]; then
        eprintf "ERROR: White Queen [%s] and Black Queen [%s] have the same position.\n" "${wqxy}" "${bqxy}"
        printf "%s\n" "same position"
        show_usage
        (( retval++ ))

    # Second argument: White Queen x,y Position
    elif [[ ! ${wqxy} =~ ^[0-7],[0-7]$ ]]; then
        eprintf "ERROR: Second argument [%s] isn't in the format \"x,y\".\n" "${wqxy}"
        show_usage
        (( retval++ ))

    # Third argument: Black Queen Flag
    elif [[ ${bqf} != -b ]]; then
        eprintf "ERROR: First argument [%s] isn't \"-b\".\n" "${bqf}"
        show_usage
        (( retval++ ))

    # Second argument: White Queen x,y Negative Positions
    elif [[ ${wqxy} =~ ^(-[0-9],[0-9]|[0-9],-[0-9]|-[0-9],-[0-9])$ ]]; then
        eprintf "ERROR: Second argument [%s] can't contain negative numberts.\n" "${wqxy}"
        printf "%s\n" "row not positive OR column not positive"
        show_usage
        (( retval++ ))

    # Fourth argument: Black Queen x,y out of range
    elif [[ ${bqxy} =~ [8-9] ]]; then
        eprintf "ERROR: Second argument [%s] row/column not on board.\n" "${bqxy}"

        if [[ ! ${bqxy} =~ ^[0-7],[8-9]$ ]]; then
            eprintf "ERROR: Second argument [%s] row not on board.\n" "${bqxy}"
            printf "%s\n" "row not on board"
        elif [[ ! ${bqxy} =~ ^[8-9],[0-7]$ ]]; then
            eprintf "ERROR: Second argument [%s] column not on board.\n" "${bqxy}"
            printf "%s\n" "column not on board"
        fi

        show_usage
        (( retval++ ))

    # Fourth argument: Black Queen x,y Position
    elif [[ ! ${bqxy} =~ ^[0-7],[0-7]$ ]]; then
        eprintf "ERROR: Second argument [%s] isn't in the format \"x,y\".\n" "${bqxy}"
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
        printf "%s\n\n" "Given the position of two queens on a chess board, indicate whether or not they are positioned so that they can attack each other."
        printf "Usage: %s -w [0-7],[0-7] -b [0-7],[0-7]" "$0"
        printf "\n"
    } >&2
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: Calculate slope between two points.
# Input : x1, y1, x2, y2
# Output: slope
# Return: 0
slope()
{
    local -i x1="${1}"
    local -i y1="${2}"
    local -i x2="${3}"
    local -i y2="${4}"

    local -i slope

    if [[ ${x1} -eq ${x2} ]]; then
        # Technically undefined, using 0 here.
        slope=0
    else
        slope="$(bc -l <<< "scale=4; s=(${y2} - ${y1}) / (${x2} - ${x1}); s*=1000; scale=0; s/=1; if (s < 0) s*=-1; s")"
    fi

    printf "%s" "${slope}"
} # slope()

# Function: Determine if two queens can attach each other.
# Input : (x,y), (x,y)
# Output: true/false
# Return: 0
queen_attack()
{
    local wqxy="${1}"
    local bqxy="${2}"

    eprintf "wqxy = [%s]\n" "${wqxy}"
    eprintf "bqxy = [%s]\n" "${bqxy}"

    local -i wqx
    local -i wqy
    local -i bqx
    local -i bqy

    local -i slope

    wqx="${wqxy%%,*}"
    wqy="${wqxy##*,}"

    bqx="${bqxy%%,*}"
    bqy="${bqxy##*,}"

    eprintf "White Queen: (%s, %s)\n" "${wqx}" "${wqy}"
    eprintf "Black Queen: (%s, %s)\n" "${bqx}" "${bqy}"
    eprintf "\n"

    # Looking for a slope of 0 or 1000.
    # Since it's easier to work with integers, the fractional part was preserved
    # by multiplying the numbers by 1k to make sure that we know 0 is really
    # zero and not a number between 0 and 1.
    slope="$(slope "${wqx}" "${wqy}" "${bqx}" "${bqy}")"

    eprintf "slope = %s\n" "${slope}"
    eprintf "\n"

    if [[ ${slope} -eq 0 ]] || [[ ${slope} -eq 1000 ]]; then
        printf "%s" "true"
        return 0
    else
        printf "%s" "false"
        return 1
    fi
} # queen_attack()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local wqxy="${2}"
    local bqxy="${4}"

    local output

    output="$(queen_attack "${wqxy}" "${bqxy}")"

    eprintf "Queens can attack each other? [%s]\n" "${output}"
    ${DEBUG} || printf "%s\n" "${output}"
} # main()

# Run the main function.
main "${@}"
