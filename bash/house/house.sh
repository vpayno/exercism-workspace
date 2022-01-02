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
# This syntax let's us run it like this: DEBUG=true bash ./atbash_cipher.sh encode "message"
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
    local -i start="${1}"
    local -i end="${2}"

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # Two arguments?
    if [[ ${#vargs[@]} -ne 2 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # Is the second argument larger than the first?
    elif [[ ${start} -gt ${end} ]]; then
        eprintf "ERROR: start [%d] can't be larger than end [%d].\n" "${start}" "${end}"
        show_usage
        printf "%s\n" "Error: invalid start/end value."
        (( retval++ ))

    # Are the arguments between 1 and 12?
    elif [[ ${start} -lt 1 ]] || [[ ${start} -gt 12 ]]; then
        eprintf "ERROR: start [%d] can only be between 1 and 12 (inclusive).\n" "${start}"
        show_usage
        printf "%s\n" "Error: invalid start value."
        (( retval++ ))

    # Are the arguments between 1 and 12?
    elif [[ ${end} -lt 1 ]] || [[ ${end} -gt 12 ]]; then
        eprintf "ERROR: invalid end [%d] can only be between 1 and 12 (inclusive).\n" "${end}"
        show_usage
        printf "%s\n" "Error: invalid end value."
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
        printf "%s\n" "Recite the nursery rhyme 'This is the House that Jack Built'."
        printf "Usage: %s start end" "$0"
        printf "\n"
    } >&2
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: Resite the lyrics.
# Input : start (int), end (int)
# Output: lyrics
# Return: 0
rhyme()
{
    local -i start="${1}-1"
    local -i end="${2}-1"

    local -i level="0"

    local -A part1=(
        [0]="This is the"
        ["horse and the hound and the horn"]="This is the"
        ["farmer sowing his corn"]="that belonged to the"
        ["rooster that crowed in the morn"]="that kept the"
        ["priest all shaven and shorn"]="that woke the"
        ["man all tattered and torn"]="that married the"
        ["maiden all forlorn"]="that kissed the"
        ["cow with the crumpled horn"]="that milked the"
        ["dog"]="that tossed the"
        ["cat"]="that worried the"
        ["rat"]="that killed the"
        ["malt"]="that ate the"
        ["house that Jack built."]="that lay in the"
    )
    local -A part2=(
        [11]="horse and the hound and the horn"
        [10]="farmer sowing his corn"
        [9]="rooster that crowed in the morn"
        [8]="priest all shaven and shorn"
        [7]="man all tattered and torn"
        [6]="maiden all forlorn"
        [5]="cow with the crumpled horn"
        [4]="dog"
        [3]="cat"
        [2]="rat"
        [1]="malt"
        [0]="house that Jack built."
    )

    _rhyme()
    {
        local -i level="${1}"

        eprintf "Level: %d\n" "${level}"
        ${DEBUG} && sleep 0.5s

        # Only print the part of the rhyme in the selected range start-end.
        for (( i=0, j=level; i <= level; i++, j--)); do
            if [[ ${i} -eq 0 ]]; then
                printf "%s %s\n" "${part1[${i}]}" "${part2[${j}]}"
            else
                printf "%s %s\n" "${part1[${part2[${j}]}]}" "${part2[${j}]}"
            fi
        done

        # We need to stop when we run out of rhymes! The last level printed is 12.
        if [[ ${level} -gt 10 ]] || [[ ${level} -eq ${end} ]]; then
            return 0
        fi

        printf "\n"

        # Next rhyme level.
        # The ++ operator before the variable, increments the number and then passes the result.
        # If it's after, the value is passed first, then incremented.
        _rhyme $(( ++level ))
    } # _rhyme()

    _rhyme "${start}"
} # rhyme()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local -i start="${1}"
    local -i end="${2}"

    eprintf "Start: [%d]\n" "${start}"
    eprintf "  End: [%d]\n" "${end}"
    eprintf "\n"

    rhyme "${start}" "${end}"
} # main()

# Run the main function.
main "${@}"
