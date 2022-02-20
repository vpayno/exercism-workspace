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

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # Two arguments?
    if [[ ${#vargs[@]} -ne 0 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
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
        printf "%s\n\n" "An evaluator for a very simple subset of Forth."
        printf "Usage: %s \"input data\"\n" "$0"
        printf "\n"
    } >&2
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: trim whitespace at the end of the string.
# Input : string (ref)
# Output: string with no leading or traling whitespace
# Return: 0 (trimmed) or 1 (not trimmed)
trim()
{
    local -n __line="${1}"

    # remove traling whitespace
    __line="${__line#"${__line%%[![:space:]]*}"}"

    # remove leading whitespace
    __line="${__line%"${__line##*[![:space:]]}"}"
} # trim()

# Function: forth interpreter
# Input : string
# Output: string
# Return: 0
forth()
{
    set -o noglob

    local -n __lines="${1}"

    local -i retval=0
    local line
    local result
    local -a stack
    local -A macros
    local macro_string
    local macro_name
    local item
    local last_op

    for line in "${__lines[@]}"; do
        eprintf "Processing line: [%s]\n" "${line}"

        for item in ${line}; do
            eprintf "\tProcessing item: [%s]\n" "${item}"

            if [[ -z ${last_op} ]] && [[ "${macros["${item}}"]:-not_set}" != not_set ]]; then
                item="${macros[${item}]}"
            fi

            if [[ ${item} =~ ^-?[[:digit:]]+$ ]]; then
                eprintf "\t\tAdding number [%d] to the stack.\n" "${item}"
                stack+=( "${item}" )
                eprintf "\t\tStack Size [%d]: [%s]\n" "${#stack[@]}" "${stack[*]}"

            elif [[ "${item,,}" =~ ^:$ ]]; then

                last_op=":"

                continue

            elif [[ ${last_op} =~ ^:[[:alpha:]]*$ ]]; then

                if [[ ! "${line}" =~ ^:.*\;$ ]]; then

                    result="macro not terminated with semicolon"
                    retval+=1
                    break 2

                elif [[ ${item,,} == ";" ]]; then

                    macro_name="${last_op#:}"

                    if [[ ${macros[${macro_name}]:-not_set} == not_set ]]; then

                        result="empty macro definition"
                        retval+=1
                        break 2

                    fi

                elif [[ "${item,,}" =~ ^[[:alpha:]]+$ ]]; then
                    eprintf "\t\tCaught Macro Name: [%s]\n" "${item,,}"
                    last_op=":${item,,}"

                elif [[ ${last_op#:} =~ ^[[:alpha:]]+$ ]]; then

                    macro_name="${last_op#:}"
                    macro_string="${line%"${macro_name}"}"
                    macro_string="${macro_string%;}"
                    trim macro_string
                    macros["${macro_name}"]="${macro_string}"
                    last_op=""

                    # stop processing this line
                    break 1
                fi

            elif [[ "${item,,}" =~ ^over$ ]]; then

                last_op="over"

                if [[ ${#stack[@]} -ge 2 ]]; then
                    eprintf "\t\tOvering [%d] over [%d]\n" "${stack[-2]}" "${stack[-1]}"
                    result="${stack[*]} ${stack[-2]}"
                    stack=( "${stack[@]}" "${stack[-2]}" )

                elif [[ ${#stack[@]} -eq 0 ]]; then
                    result="empty stack"
                    stack=()
                    retval+=1

                elif [[ ${#stack[@]} -eq 1 ]]; then
                    result="only one value on the stack"
                    stack=()
                    retval+=1

                fi

            elif [[ "${item,,}" =~ ^swap$ ]]; then

                last_op="swap"

                if [[ ${#stack[@]} -ge 2 ]]; then
                    eprintf "\t\tSwapping [%d] & [%d]\n" "${stack[-2]}" "${stack[-1]}"
                    result="${stack[*]::${#stack[*]}-2} ${stack[-1]} ${stack[-2]}"
                    stack=( "${stack[@]::${#stack[@]}-2}" "${stack[-1]}" "${stack[-2]}" )

                elif [[ ${#stack[@]} -eq 0 ]]; then
                    result="empty stack"
                    stack=()
                    retval+=1

                elif [[ ${#stack[@]} -eq 1 ]]; then
                    result="only one value on the stack"
                    stack=()
                    retval+=1

                fi

            elif [[ "${item,,}" =~ ^drop$ ]]; then

                last_op="drop"

                if [[ ${#stack[@]} -ge 1 ]]; then
                    eprintf "\t\tDropping [%d]\n" "${stack[-1]}"
                    result="${stack[*]::${#stack[*]}-1}"
                    stack=( "${stack[@]::${#stack[@]}-1}" )

                elif [[ ${#stack[@]} -eq 0 ]]; then
                    result="empty stack"
                    stack=()
                    retval+=1

                fi

            elif [[ "${item,,}" =~ ^dup$ ]]; then

                last_op="dup"

                if [[ ${#stack[@]} -ge 1 ]]; then
                    eprintf "\t\tDuplicating [%d]\n" "${stack[-1]}"
                    result="${stack[*]} ${stack[-1]}"
                    stack+=( "${stack[-1]}" )

                elif [[ ${#stack[@]} -eq 0 ]]; then
                    result="empty stack"
                    retval+=1

                fi

            elif [[ "${item}" =~ ^[+*/-]$ ]]; then

                last_op="${item}"

                if [[ ${#stack[@]} -eq 2 ]]; then
                    eprintf "\t\tCalculating: %d %s %d\n" "${stack[0]}" "${item}" "${stack[1]}"

                    if [[ ${item} == / ]] && [[ ${stack[1]} -eq 0 ]]; then
                        eprintf "\t\tCaught: divide by zero\n"
                        result="divide by zero"
                        stack=()
                        retval+=1
                    else
                        result="$(bc -l <<< "scale=0; ${stack[0]} ${item} ${stack[1]}")"
                        stack=( "${result}" )
                    fi

                elif [[ ${#stack[@]} -eq 1 ]]; then
                    result="only one value on the stack"
                    stack=()
                    retval+=1

                elif [[ ${#stack[@]} -eq 0 ]]; then
                    result="empty stack"
                    stack=()
                    retval+=1

                fi

            else
                eprintf "\t\tFound item [%s]\n" "${item}"
            fi

            if [[ ${retval} -gt 0 ]]; then
                break 2
            fi
        done
    done

    if [[ -z ${result} ]] && [[ -z ${last_op} ]]; then
        eprintf "Fallback: ouput input\n"
        result="${stack[*]}"
    fi

    trim result

    eprintf "Result: [%s]\n" "${result}"
    printf "%s" "${result}"
    return "${retval}"
} # forth()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    # If there aren't any arguments, grab input from standard input.
    set -- "${@:-$(</dev/stdin)}"

    local output_text
    local -a lines
    local line

    while read -r line; do
        lines+=( "${line}" )
    done <<< "$@"

    output_text="$(forth lines)"
    retval="$?"

    eprintf "[%s]\n" "${output_text}"
    ${DEBUG} || printf "%s\n" "${output_text}"

    return "${retval}"
} # main()

# Run the main function.
main "${@}"  || exit "$?"
