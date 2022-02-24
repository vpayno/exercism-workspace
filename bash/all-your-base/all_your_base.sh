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
    local source_base="${1}"
    local number="${2}"
    local target_base="${3}"

    # Variable used to track the return codes from each of the checks.
    local -i retval=0
    local -i n

    # Three arguments?
    if [[ ${#vargs[@]} -ne 3 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # First argument: source base?
    elif [[ ! ${source_base} =~ ^[0-9]+$ ]]; then
        eprintf "ERROR: source base [%s] can only be a a positive number greater than 1.\n" "${source_base}"
        show_usage
        (( retval++ ))

    # First argument: source base < 2?
    elif [[ ${source_base} -le 1 ]]; then
        eprintf "ERROR: source base [%s] can only be a a positive number greater than 1.\n" "${source_base}"
        show_usage
        (( retval++ ))

    # Second argument: space separated digits? Needs to allow an empty list so we can fail successfully. :(
    elif [[ ! ${number} =~ ^([0-9][[:blank:]]?|)+$ ]]; then
        eprintf "ERROR: number [%s] needs to be a positive number with each digit separated by a space .\n" "${number}"
        show_usage
        (( retval++ ))

    # First argument: target base?
    elif [[ ! ${target_base} =~ ^[0-9]+$ ]] || [[ ${target_base} -le 1 ]]; then
        eprintf "ERROR: target base [%s] can only be a a positive number greater than 1.\n" "${target_base}"
        show_usage
        (( retval++ ))

    fi

    # Second argument: valid numbers that are (0 <= n < base)?
    for n in ${number}; do
        if [[ ${n} -ge "${source_base}" ]]; then
            eprintf "ERROR: number [%s] has numbers in it larger than the base [%d] allows.\n" "${number}" "${source_base}"
            show_usage
            (( retval++ ))
            break
        fi
    done

    if [[ ${retval} -eq 0 ]]; then
        # For some reason if the number we're converting is zero, instead of
        # outputing zero, the program is supposed to output nothing successfully.
        # Same if the number is an empty list/string.
        n="${number// /}"

        if [[ ${n} -eq 0 ]] || [[ -z ${number// /} ]]; then
            exit 0
        fi
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
        printf "%s\n\n" "Convert a number, represented as a sequence of digits in one base, to any other base."
        printf "Usage: %s 2 \"1 0 1 0 1 0\" 16" "$0"
        printf "\n"
    } >&2
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: Formats numbers based on base.
# Input : base, number (space delimited), return variable
# Output: formated number (string) via reference
# Return: 0
format_number()
{
    local -i base="${1}"
    local ugly_number="${2}"
    local -n __return="${3}"

    local -i index
    local -a letters
    local -A letter2int
    local -A int2letter

    local -a -i numbers
    local -i number
    local -a chars

    if [[ ${base} -gt 10 ]]; then
        eprintf "Formatting Base [%d] number...\n\n" "${base}"

        # Generate a string with the letters A to Z.
        # Adding an offset to the start of the array so the letters have indexes 1-26.
        letters=( _ {A..Z} )

        # Generate a key table so we can translate a letter to it's output value.
        # f -> forward index
        for (( index=1; "${index}" <= 26; index++ )); do
            # Instead of manually writing these out, let's auto-generate the key table.
            # shellcheck disable=SC2046
            {
                eval $(printf "letter2int[\"%s\"]=\"%d\"\n" "${letters[${index}]}" "${index}")
                eval $(printf "int2letter[\"%d\"]=\"%s\"\n" "${index}" "${letters[${index}]}")
            }
        done

        ${DEBUG} && declare -A -p letter2int
        eprintf "\n"
        ${DEBUG} && declare -A -p int2letter
        eprintf "\n"

        # shellcheck disable=SC2206
        numbers=( ${ugly_number} )

        for number in "${numbers[@]}"; do
            if [[ ${number} -ge 10 ]]; then
                number="${number} - 9"
                chars+=( "${int2letter[${number}]}" )
            else
                chars+=( "${number}" )
            fi
        done

        __return="${chars[*]}"
    else
        eprintf "Skipping formatting of numbers with a base lower than 11. [%d]\n\n" "${base}"

        __return="${ugly_number}"
    fi

    eprintf "Number Before Formating: [%s]\n" "${ugly_number}"
    eprintf " Number After Formating: [%s]\n" "${__return}"
} # format_number()

# Function: convert number to a different base
# Input : source base, source number and target base
# Output: target number via reference variable
# Return: 0
convert_base()
{
    local -i source_base="${1}"
    local source_number="${2}"  # not an int, it's space delimited
    local -i target_base="${3}"
    local -n __target_number="${4}"

    local -i intermediate
    local -i position
    local -i quotient
    local -i remainder
    local -i base

    local -a -i numbers
    local -i number
    local -i result

    # I would have prefered it if they passed a number without spaces instead
    # of a space delimited number.
    # shellcheck disable=SC2206
    numbers=( ${source_number} )
    eprintf "numbers=( %s )\n" "${numbers[*]}"

    # 1. Convert old base number to base 10.
    if [[ ${source_base} -eq 10 ]]; then
        eprintf "Source number is already base 10, not converting.\n"

        # Why are there spaces in the number?
        intermediate="${source_number// /}"
    else
        eprintf "Using positional notation to convert the source number to decimal.\n"

        # use positional notation
        # n x base ^ (position - 1) + ...

        position="${#numbers[@]}"
        base="${source_base}"

        for number in "${numbers[@]}"; do
            result="$(bc -l <<< "${number} * ${base} ^ (${position} - 1)")"
            eprintf "result=%d * %d ^ (%d - 1)\n" "${number}" "${base}" "${position}"

            eprintf "%d=%d+%d\n" "$(( intermediate + result ))" "${result}" "${intermediate}"
            intermediate+="${result}"

            (( position-- ))

            eprintf "\n"
        done
    fi

    eprintf "Decimal intermediate: [%d]\n\n" "${intermediate}"

    # 2. Convert base 10 number to new base.
    if [[ ${target_base} -eq 10 ]]; then
        eprintf "Target number is already base 10, not converting.\n"

        __target_number="$(printf "%s" "${intermediate}" | sed -r -e 's/./& /g')"
        __target_number="${__target_number% }"
    else
        eprintf "Converting decimal intermediate to base [%d]\n" "${target_base}"

        # 1. n / b = q, n % b = r
        # 2. r -> 1st least significant digit
        # 3. q / b = q, q % b = r
        # 4. r -> 2nd least significant digit
        # 5. repeat steps 3 & 4

        base="${target_base}"
        number="${intermediate}"

        eprintf "%d = %d / %d\n" "$(( number / base ))" "${number}" "${base}"
        quotient="${number} / ${base}"

        eprintf "%d = %d %% %d\n" "$(( number % base ))" "${number}" "${base}"
        remainder="${number} % ${base}"

        __target_number="${remainder}"

        while [[ ${quotient} -gt 0 ]]; do
            number="${quotient}"

            eprintf "%d = %d / %d\n" "$(( number / base ))" "${number}" "${base}"
            quotient="${number} / ${base}"

            eprintf "%d = %d %% %d\n" "$(( number % base ))" "${number}" "${base}"
            remainder="${number} % ${base}"

            __target_number="${remainder} ${__target_number}"

            eprintf "\n"
        done
    fi

    eprintf "Base [%d] number: [%s]\n" "${target_base}" "${__target_number}"

    eprintf "\n"
} # convert_base()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local -i source_base="${1}"
    local source_number="${2}"  # not an int, it's space delimited
    local -i target_base="${3}"

    local target_number
    local pprint_number

    convert_base "${source_base}" "${source_number}" "${target_base}" "target_number"

    eprintf "  Source Base: [%d]\n" "${source_base}"
    eprintf "Source Number: [%s]\n" "${source_number// /}"
    eprintf "\n"
    eprintf "  Target Base: [%s]\n" "${target_base}"
    eprintf "Target Number: [%s]\n" "${target_number}"
    eprintf "\n"

    format_number "${target_base}" "${target_number}" "pprint_number"
    eprintf "Pretty Print Target Number: [%s]\n" "${pprint_number}"
    eprintf "\n"

    eprintf "[%s](%d) == [%s](%d)\n" "${source_number// /}" "${source_base}" "${pprint_number// /}" "${target_base}"
    eprintf "\n"

    # Why is it space delimited? A real program wouldn't do that.
    ${DEBUG} || printf "%s\n" "${target_number}"
} # main()

# Run the main function.
main "${@}"
