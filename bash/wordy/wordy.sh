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
    local input="${1}"

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # Two arguments?
    if [[ ${#vargs[@]} -ne 1 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # Properly formatted? prefix notation
    elif [[ ${input} =~ ^What[[:blank:]]is[[:blank:]][[:alpha:]]+[[:blank:]]-?[0-9]+[[:blank:]]-?[0-9]+\?$ ]]; then
        #eprintf "ERROR: input [%s] needs to be in the format \"What is NUMBER OPERATION NUMBER [OPERATION NUMBER]?\".\n" "${input}"
        printf "syntax error\n"
        #show_usage
        (( retval++ ))

    # Properly formatted? postfix notation
    elif [[ ${input} =~ ^What[[:blank:]]is[[:blank:]]-?[0-9]+[[:blank:]]-?[0-9]+[[:blank:]][[:alpha:]]+\?$ ]]; then
        #eprintf "ERROR: input [%s] needs to be in the format \"What is NUMBER OPERATION NUMBER [OPERATION NUMBER]?\".\n" "${input}"
        printf "syntax error\n"
        #show_usage
        (( retval++ ))

    # Properly formatted? unknown operation
    elif [[ ${input} =~ ^What[[:blank:]]is[[:blank:]]-?[0-9]+[[:blank:]][^pmd].*$ ]]; then
        #eprintf "ERROR: input [%s] needs to be in the format \"What is NUMBER OPERATION NUMBER [OPERATION NUMBER]?\".\n" "${input}"
        printf "unknown operation\n"
        #show_usage
        (( retval++ ))

    # Properly formatted? unknown operation
    elif [[ ${input} =~ ^Who[[:blank:]]is.*$ ]]; then
        #eprintf "ERROR: input [%s] needs to be in the format \"What is NUMBER OPERATION NUMBER [OPERATION NUMBER]?\".\n" "${input}"
        printf "unknown operation\n"
        #show_usage
        (( retval++ ))

    # Properly formatted? 1 or 2 operators
    elif [[ ! ${input} =~ ^What[[:blank:]]is[[:blank:]]-?[0-9]+([[:blank:]](plus|minus|multiplied[[:blank:]]by|divided[[:blank:]]by)[[:blank:]]-?[0-9]+([[:blank:]](plus|minus|multiplied[[:blank:]]by|divided[[:blank:]]by)[[:blank:]]-?[0-9]+)?)?\?$ ]]; then
        #eprintf "ERROR: input [%s] needs to be in the format \"What is NUMBER OPERATION NUMBER [OPERATION NUMBER]?\".\n" "${input}"
        printf "syntax error\n"
        #show_usage
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
        printf "\n%s\n\n" "Parse and evaluate simple math word problems returning the answer as an integer."
        printf "Usage: %s %s\n" "\"What is NUMBER OPERATION NUMBER [OPERATION NUMBER]?\"" "$0"
        printf "\n\tOperation: %s\n" "plus | minus | multiplied by | divided by"
        printf "\n\tNumber   : %s\n" "positive or negative whole numbers"
        printf "\n"
    } >&2
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: "parse" the phrase for the math equation
# Input : string
# Output: integer
# Return: 0
calc1()
{
    local phrase="${1}"

    local equation
    local -i result

    eprintf "Original Phrase: [%s]\n" "${phrase}"

    # use parenthesis to change the order of operations
    equation="$(printf "%s" "${phrase}" | sed -r -e 's/(-?[0-9]+) (plus|minus|multiplied by|divided by) (-?[0-9]+)/(\1 \2 \3)/g')"

    # change the phrase into an equation
    equation="${equation//What is /}"
    equation="${equation//\?/}"
    equation="${equation//plus/+}"
    equation="${equation//minus/-}"
    equation="${equation//multiplied by/*}"
    equation="${equation//divided by//}"

    eprintf "Equation: [%s]\n" "${equation}"

    # since the result is an integer, the equation will be evaluated and saved
    result="${equation}"

    eprintf "Result: [%d]\n" "${result}"

    printf "%s" "${result}"
} # calc1()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local phrase="${1}"

    local -i output

    output="$(calc1 "${phrase}")"

    eprintf "[%s]\n" "${output}"
    ${DEBUG} || printf "%s\n" "${output}"
} # main()

# Run the main function.
main "${@}"
