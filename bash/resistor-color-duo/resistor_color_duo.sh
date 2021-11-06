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

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # Because of the tests, we need to test that we get at least one value.
    if [[ ${#vargs[@]} -lt 1 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]:-none passed}" "${#vargs[@]}"
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
    printf "Usage: %s \"<string>\"" "$0"
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: checks to see if the color is valid
# Input : a color
# Output: none
# Return: 0 (valid), 1 (invalid)
is_color_valid()
{
    local color="${1,,}"

    local found="false"
    local key

    for key in "${!color_table[@]}"; do
        if [[ ${color} == "${key}" ]]; then
            found="true"
            break
        fi
    done

    # shellcheck disable=SC2046
    return $(${found})
} # is_color_valid()

# Function: returns the interger value for a color
# Input : a color
# Output: color value
# Return: 0 (valid), 1 (invalid)
get_color_value()
{
    local color_name="${1,,}"

    local -i color_value=0

    if is_color_valid "${color_name}"; then
        color_value="${color_table[${color_name}]}"
        eprintf "Color [%s] value is [%s].\n" "${color_name}" "${color_value}"
        printf "%s" "${color_value}"
        return 0
    else
        eprintf "Color [%s] is invalid.\n" "${color_name}"
        return 1
    fi
} # get_color_value()

# Function: returns the resister value
# Input : two colors
# Output: resister value
# Return: 0
get_resistor_value()
{
    local color1="${1,,}"
    local color2="${2,,}"

    # If you don't use '-i' here, the += below will treat the values like a string.
    local resistor_value

    # If there's a failure in the function call, catch it and return it.
    resistor_value="$(get_color_value "${color1}")" || return $?
    resistor_value+="$(get_color_value "${color2}")" || return $?

    printf "%s" "${resistor_value}"
    return
} # get_resistor_value()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local color1="${1,,}"
    local color2="${2,,}"

    local resistor_value

    # Used by is_color_valid() and get_color_value()
    local -A color_table

    color_table["black"]=0
    color_table["brown"]=1
    color_table["red"]=2
    color_table["orange"]=3
    color_table["yellow"]=4
    color_table["green"]=5
    color_table["blue"]=6
    color_table["violet"]=7
    color_table["grey"]=8
    color_table["white"]=9

    if ! is_color_valid "${color1}"; then
        printf "ERROR: invalid color [%s]\n" "${color1}"
    elif ! is_color_valid "${color2}"; then
        printf "ERROR: invalid color [%s]\n" "${color2}"
    fi

    resistor_value="$(get_resistor_value "${color1}" "${color2}")" || return ${?}

    eprintf "\n"
    eprintf "Color1        : [%s]\n" "${color1}"
    eprintf "Color2        : [%s]\n" "${color2}"
    eprintf "Resister Value: [%s]\n" "${resistor_value}"
    ${DEBUG} || printf "%s\n" "${resistor_value}"
} # main()

# Run the main function.
main "${@}"
