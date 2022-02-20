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

    # Two arguments?
    if [[ ${#vargs[@]} -ne 1 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # First argument: a decimal number?
    elif [[ ! ${number} =~ ^[0-9]+$ ]]; then
        eprintf "ERROR: number [%s] can only be a positive decimal.\n" "${number}"
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
        printf "%s\n\n" "Convert from normal numbers to Roman Numerals."
        printf "Usage: %s \"<number>\"" "$0"
        printf "\n"
    } >&2
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: convert a decimal number to a Roman numeral
# Input : number
# Output: string
# Return: 0
dec2roman()
{
    local -i number="${1}"

    local -i remainder
    local -i register
    local -i sub_num
    local output

    local -A d2r=(
        [1]="I"
        [5]="V"
        [10]="X"
        [50]="L"
        [100]="C"
        [500]="D"
        [1000]="M"
    )

    local -A sub_ladder=(
        [10]=1
        [50]=10
        [100]=10
        [500]=100
        [1000]=100
    )

    local -A out_ladder=(
        [10]=I
        [50]=X
        [100]=X
        [500]=C
        [1000]=C
    )

    remainder="${number}"

    # Steps
    # 1. set remainder to number
    # 2. divide remainder by 1000
    # 3. if == 0 then look for special case for IV, IX, XL, XC, CD, CM
    #    a. if true then record it and substract it from the remainder
    #    b. if false continue with the next number
    # 4. if != 0 then
    #    a. output n, nn, nnn case
    #    b. update the remainder
    #    c. continue with the next number

    for next in 1000 500 100 50 10 5 1; do

        # end this if the remainder is <= 0
        if [[ ${remainder} -le 0 ]]; then
            eprintf "remainder (%s) <= 0" "${remainder}"
            break
        fi

        register="$(( remainder / next ))"

        eprintf "% 4d / % 4d == % 4d -> " "${remainder}" "${next}" "${register}"

        if [[ ${register} -eq 0 ]]; then

            eprintf "%s\n" "true"

            sub_num="${sub_ladder[${next}]:-1}"

            eprintf "% 4d >= % 4d - % 4d -> " "${remainder}" "${next}" "${sub_num}"

            if (( remainder >= next - sub_num )); then

                eprintf "%s\n" "true"

                # IV IX XL XC CD CM
                output+="${out_ladder[${next}]:-I}${d2r[${next}]}"

                eprintf "%s + %s -> %s\n" "${out_ladder[${next}]:-I}" "${d2r[${next}]}" "${output}"

                # update the remainder
                register="${remainder} - (${next} - ${sub_num})"
                eprintf "remainder: % 4d = % 4d - (% 4d - % 4d)\n" "${register}" "${remainder}" "${next}" "${sub_num}"
                remainder="${register}"

                # done with this iteration
                eprintf "\n"
                continue

            else

                eprintf "%s\n" "false"

                # noting to do for this iteration
                eprintf "\n"
                continue

            fi

        else

            eprintf "%s\n" "false"

            # III xxx CCC
            output+="$(printf "%.0s${d2r[${next}]}" $(seq 1 "${register}"))"

            eprintf "%s x %d -> %s\n" "${d2r[${next}]}" "${register}" "${output}"

            # update the remainder
            (( register = remainder % next ))
            eprintf "remainder: % 4d = % 4d %% % 4d\n" "${register}" "${remainder}" "${next}"
            remainder="${register}"

            # done with this iteration
            continue

        fi

    done

    printf "%s" "${output^^}"
} # dec2roman()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local -i number="${1}"

    local output_text

    output_text="$(dec2roman "${number}")"

    eprintf "\n"
    eprintf "Decimal Number: [%d]\n" "${number}"
    eprintf " Roman Numeral: [%s]\n" "${output_text}"

    ${DEBUG} || printf "%s\n" "${output_text}"
} # main()

# Run the main function.
main "${@}"
