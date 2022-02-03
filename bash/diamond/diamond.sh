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
    local letter="${1^^}"  # uppercase the string

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # One argument?
    if [[ ${#vargs[@]} -ne 1 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # First argument: A-Z?
    elif [[ ! ${letter} =~ ^[A-Z]$ ]]; then
        eprintf "ERROR: letter [%s] can only be a letter between A and Z.\n" "${letter}"
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
        printf "%s\n\n" "The diamond kata takes as its input a letter, and outputs it in a diamond shape. Given a letter, it prints a diamond starting with 'A', with the supplied letter at the widest point."
        printf "Usage: %s \"<A-Z>\"" "$0"
        printf "\n"
    } >&2
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: Generates a diamond kata using an input letter.
# Input : char
# Output: array of strings
# Return: 0
generate_diamond()
{
    local end_letter="${1^^}"

    local -a lines
    local line

    local -A letter2int
    local -A int2letter
    local letters
    local f

    # Generate a string with the letters A to Z.
    # Adding an offset to the start of the string so the letters have indexes 1-26.
    letters="_$(printf "%s" {A..Z})"

    # Generate a key table so we can translate a letter to it's output value.
    # f -> forward index
    for (( f=1; "${f}" <= 26; f++ )); do
        # Instead of manually writing these out, let's auto-generate the key table.
        # shellcheck disable=SC2046
        {
            eval $(printf "letter2int[\"%s\"]=\"%d\"\n" "${letters:${f}:1}" "${f}")
            eval $(printf "int2letter[\"%d\"]=\"%s\"\n" "${f}" "${letters:${f}:1}")
        }
    done

    local -i end_letter_index
    local -i end_of_line
    local -i space_between_letters
    local -i col
    local -i row
    local line
    local -a lines

    # L = Given Letter Index (1-26)
    # R = Index Of Row
    # Start of line: L, L-1, L-2, .., L-L
    # End of line|Height of diamond: 2L-1
    # Space between letters: NA, (R-2)+(R-1) | 2R-3
    # Width of middle|Width of ASCII art: 2L-1

    _place_letter()
    {
        local -i first_letter_index
        local -i space_between_letters
        local -i second_letter_index

        eprintf "Testing position for letter [%s](%d)\n" "${int2letter[${row}]}" "${row}"

        first_letter_index="$(( end_letter_index - (row - 1) ))"
        eprintf "first_letter_index: [%d - (%d - 1)] = [%s]\n" "${end_letter_index}" "${row}" "${first_letter_index}"

        if (( first_letter_index == col )); then
			eprintf "first_letter_index [%d] == [%d] col\n" "${first_letter_index}" "${col}"
            return 0
        fi

        space_between_letters="$(( (2 * row) - 3 ))"

        eprintf "space_between_letters: [(2 * %d) - 3] = [%s]\n" "${row}" "${space_between_letters}"

        if [[ ${space_between_letters} -gt 0 ]]; then

            second_letter_index="$(( first_letter_index + space_between_letters + 1 ))"

            eprintf "second_letter_index [%d + %d + 1] = [%d]\n" "${first_letter_index}" "${space_between_letters}" "${second_letter_index}"

            if (( second_letter_index == col )); then
                eprintf "second_letter_index [%d] == [%d] col\n" "${second_letter_index}" "${col}"
                return 0
            fi

        fi

        return 1
    } # _place_letter()

	end_letter_index="${letter2int[${end_letter}]}"

	eprintf "end_letter_index [%s] = [%s]\n" "${end_letter}" "${end_letter_index}"

    # If A was passed, only print it and return.
    if [[ ${end_letter_index} -eq 1 ]]; then
        lines=( "A" )
    else
        end_of_line=$(( (end_letter_index * 2) - 1 ))

        eprintf "for row in %d .. %d\n" 1 "${end_letter_index}"
        for row in $(seq 1 "${end_letter_index}"); do
            eprintf "for col in %d .. %d\n" 1 "${end_of_line}"
            eprintf "\n"

            for col in $(seq 1 "${end_of_line}"); do
                eprintf "(col, row) = (% 2d, % 2d):\n" "${col}" "${row}"

                if _place_letter; then
                    eprintf "%s" "${int2letter[${row}]}"
                    line="${line}${int2letter[${row}]}"
                else
                    eprintf "%s" "."
                    line="${line}_"
                fi
                eprintf "\n\n"
            done

			eprintf "[%s]\n" "${line}"
			lines+=( "${line}" )
			line=""
        done

        eprintf "for row in %d .. 1\n" "$(( end_letter_index - 1))" 1
        for row in $(seq "$(( end_letter_index - 1))" -1 1); do
            eprintf "for col in %d .. %d\n" 1 "${end_of_line}"
            eprintf "\n"

            for col in $(seq 1 "${end_of_line}"); do
                eprintf "(col, row) = (% 2d, % 2d):\n" "${col}" "${row}"

                if _place_letter; then
                    eprintf "%s" "${int2letter[${row}]}"
                    line="${line}${int2letter[${row}]}"
                else
                    eprintf "%s" "."
                    line="${line}_"
                fi
                eprintf "\n\n"
            done

			eprintf "[%s]\n" "${line}"
			lines+=( "${line}" )
			line=""
        done
    fi

    printf "%s\n" "${lines[@]}"
} # generate_diamond()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local letter="${1^^}"

    local -a diamond

    mapfile -t diamond < <(generate_diamond "${letter}")

    eprintf "\n"
    eprintf "[%s]\n" "${diamond[@]// /.}"
    ${DEBUG} || printf "%s\n" "${diamond[@]//_/ }"
} # main()

# Run the main function.
main "${@}"
