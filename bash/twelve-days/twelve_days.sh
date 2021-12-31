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
    local start="${1}"
    local end="${2}"

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # Two arguments?
    if [[ ${#vargs[@]} -ne 2 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # First Argument: integer?
    elif [[ ! ${start} =~ ^[0-9]+$ ]]; then
        eprintf "ERROR: start [%s] can only be a positive integer.\n" "${start}"
        show_usage
        (( retval++ ))

    # Second Argument: integer?
    elif [[ ! ${end} =~ ^[0-9]+$ ]]; then
        eprintf "ERROR: end [%s] can only be a positive integer.\n" "${end}"
        show_usage
        (( retval++ ))

    # Is the end equal to or larger than the start?
    elif [[ ${start} -gt "${end}" ]]; then
        eprintf "ERROR: start [%d] can't be larger than end [%d].\n" "${start}" "${end}"
        show_usage
        (( retval++ ))

    # Is start between 1 and 12?
    elif [[ ${start} -lt 1 ]] && [[ ${start} -gt 12 ]]; then
        eprintf "ERROR: start [%d] needs to be between 1 and 12.\n" "${start}"
        show_usage
        (( retval++ ))

    # Is end between 1 and 12?
    elif [[ ${end} -lt 1 ]] && [[ ${end} -gt 12 ]]; then
        eprintf "ERROR: end [%d] needs to be between 1 and 12.\n" "${end}"
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
        printf "%s\n\n" "Output the lyrics to 'The Twelve Days of Christmas'."
        printf "Usage: %s start end\n" "$0"
        printf "\t%s\n" "start: 1-12 (default=1)"
        printf "\t%s\n" "  end: 1-12 (default=12)"
        printf "\n"
    } >&2
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: Outputs the lyrics to 'The Twelve Days of Christmas'.
# Input : start (int), end (int)
# Output: Array of lyrics.
# Return: 0
twelve_days()
{
    local -i start="${1:-1}"
    local -i end="${2:-12}"

	(( start-- ))

	local -i length="${end} - ${start}"
	local -i i
	local -i j
	local line_prefix="On the %s day of Christmas my true love gave to me: "
	local line
	local -a output

	local -a days=(
		"first"
		"second"
		"third"
		"fourth"
		"fifth"
		"sixth"
		"seventh"
		"eighth"
		"ninth"
		"tenth"
		"eleventh"
		"twelfth"
	)

    local -a items=(
		"a Partridge in a Pear Tree."
		"two Turtle Doves, "
		"three French Hens, "
		"four Calling Birds, "
		"five Gold Rings, "
		"six Geese-a-Laying, "
		"seven Swans-a-Swimming, "
		"eight Maids-a-Milking, "
		"nine Ladies Dancing, "
		"ten Lords-a-Leaping, "
		"eleven Pipers Piping, "
		"twelve Drummers Drumming, "
    )

    local -a lyrics

	for i in {0..11}; do
		line=""

		j=0
		while [[ ${j} -le ${i} ]]; do
			if [[ ${j} -eq 1 ]]; then
				line="and ${line}"
			fi

			line="${items[${j}]}${line}"
			#eprintf "[%d] %s\n" "${j}" "${line}"

			(( j++ ))
		done

		# shellcheck disable=SC2059
		line="$(printf "${line_prefix}" "${days[${i}]}")${line}"
		lyrics+=( "${line}" )

		eprintf "[%d] %s\n" "${i}" "${line}"
	done
	eprintf "\n"

	eprintf " Slice Start: [%d]\n" "${start}"
	eprintf "Slice Length: [%d]\n" "${length}"
	eprintf "\n"
    eprintf "%s\n" "${lyrics[@]:${start}:${length}}"
	eprintf "\n"

	printf "%s\n" "${lyrics[@]:${start}:${length}}"
} # twelve_days()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local -i start="${1:-1}"
    local -i end="${2:-12}"

    local -a output
    local -i index=0
	local line

    eprintf "start: [%2d]\n" "${start}"
    eprintf "  end: [%2d]\n" "${end}"
    eprintf "\n"

    mapfile -t output < <(twelve_days "${start}" "${end}")

	index="${start}"
    for line in "${output[@]}"; do
        eprintf "[%2d] %s\n" "${index}" "${line}"
        ${DEBUG} || printf "%s\n" "${line}"
		(( index++ ))
    done
} # main()

# Run the main function.
main "${@}"
