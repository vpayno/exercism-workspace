#!/usr/bin/env bash
#
# Bash Reference Manual (HTML)		: https://www.gnu.org/software/bash/manual/
# Bash Reference Manual (PDF)		 : https://www.gnu.org/s/bash/manual/bash.pdf
#
# Bash Guide for Beginners (HTML)	 : https://tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html
# Bash Guide for Beginners (PDF)	  : https://tldp.org/LDP/Bash-Beginners-Guide/Bash-Beginners-Guide.pdf
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
	local command="${1,,}"
	local number="${2}"

	# Variable used to track the return codes from each of the checks.
	local -i retval=0

	# One argument?
	if [[ ${#vargs[@]} -ne 2 ]]; then
		eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
		show_usage
		(( retval++ ))

	# First argument: Is it valid?
	elif [[ ! ${command} =~ ^(square_of_sum|sum_of_squares|difference)$ ]]; then
		eprintf "ERROR: the command [%s] can only be one of: square_of_sum, sum_of_squares, difference.\n" "${command}"
		show_usage
		(( retval++ ))

	# Second argument: Is it a number?
	elif [[ ! ${number} =~ ^[0-9]+$ ]]; then
		eprintf "ERROR: the argument [%s] can only be a positive number.\n" "${number}"
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
		printf "%s\n\n" "Finds the difference between the square of the sum and the sum of the squares of the first N natural numbers."
		printf "Usage: %s (square_of_sum|sum_of_squares|difference) number" "$0"
		printf "\n"
	} >&2
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: pretty print numbers
# Input : number
# Output: formatted string
pp()
{
	# Don't use -i so it doesn't overflow on large numbers.
	local number="${1}"

	sed -re ' :restart ; s/([0-9])([0-9]{3})($|[^0-9])/\1,\2\3/ ; t restart ' <<< "${number}"
} # pp()

# Function: Calculates the square of the sums.
# Input : number
# Output: number
# Return: 0
square_of_sums()
{
	local -i number="${1}"

	local -i result=0

	result="$(bc <<< "scale=0; (${number} * (${number} + 1) / 2) ^ 2")"

	eprintf " Square of the sum of the natural numbers: %s\n" "$(pp "${result}")"
	printf "%s" "${result}"
} # square_of_sums()

# Function: Calculates the sum of the squares.
# Input : number
# Output: number
# Return: 0
sum_of_squares()
{
	local -i number="${1}"

	local -i result=0

	result="$(bc <<< "scale=0; ${number} * (${number} + 1) * (2 * ${number} + 1) / 6")"

	eprintf "Sum of the squares of the natural numbers: %s\n" "$(pp "${result}")"
	printf "%s" "${result}"
} # sum_of_squares()

# Function: Calculates the difference of the square of theum and the sum of the squres for the first n numbers.
# Input : number
# Output: number
# Return: 0
diff_of_squares()
{
	local -i number="${1}"

	local -i result=0
	local -i square_of_the_sums=0
	local -i sum_of_the_squares=0

	square_of_the_sums="$(square_of_sums "${number}")"

	sum_of_the_squares="$(sum_of_squares "${number}")"

	(( result = square_of_the_sums - sum_of_the_squares ))

	eprintf "				   Difference of the sums: %s\n" "$(pp "${result}")"
	printf "%d\n" "${result}"
} # diff_of_squares()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
	local command="${1}"
	local -i number="${2}"

	local -i result

	eprintf "Command: %s\n\n" "${command}"
	eprintf " Number: %d\n\n" "${number}"

	case "${command}" in
		square_of_sum)
			result="$(square_of_sums "${number}")"
			;;
		sum_of_squares)
			result="$(sum_of_squares "${number}")"
			;;
		difference)
			result="$(diff_of_squares "${number}")"
			;;
	esac

	${DEBUG} || printf "%d\n" "${result}"
} # main()

# Run the main function.
main "${@}"
