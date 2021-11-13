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
    ${DEBUG} || return

    # Pass all the printf arguments and redirect stdout to stderr.
    if [[ -n ${recursion_level} ]]; then
        printf "[%s] " "${recursion_level}"
        # shellcheck disable=SC2059
        printf "$@"
    else
        # shellcheck disable=SC2059
        printf "$@"
    fi >&2
} # eprintf()

# Function: check the validity of the script's arguments.
# Input : script arguments
# Output: error messages
# Return: 0 (valid) or >=1 (one or more input problems Found)
check_args()
{
    # Capture the script's arguments.
    local -a vargs=( "$@" )

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # One argument?
    if [[ ${#vargs[@]} -ne 1 ]]; then
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
    printf "Usage: %s \"<string>\"" "$0"
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: recursively scan for the closing bracket
# Input : string, search target, start position
# Output: next position + 1
# Return: 0 (no mismatched brackets), 1 (Found mismatch)
find_next_bracket()
{
    local input="${1}"

    local -i retval=0
    local -i recursion_level=-1
    local -i index=0

    # Catch for brackets that weren't closed or opened.
    local -A -x bracket_counts
    bracket_counts["square"]=0
    bracket_counts["parenthesis"]=0
    bracket_counts["curly"]=0

    # Used to find a closing bracket's counterpart.
    local -A bracket_flipper
    bracket_flipper["["]="]"
    bracket_flipper["("]=")"
    bracket_flipper["{"]="}"
    bracket_flipper["]"]="["
    bracket_flipper[")"]="("
    bracket_flipper["}"]="{"

    # Used to store a list of found brackets.
    local bracket_memory

    _are_all_brackets_matched()
    {
        local result="true"
        local -i retval=0

        if [[ ${bracket_counts["square"]} -ne 0 ]]; then
            eprintf "_are_all_brackets_matched: bracket_counts[%s] is %d\n" "square" "${bracket_counts["square"]}"
            result="false"
            retval=1
        elif [[ ${bracket_counts["parenthesis"]} -ne 0 ]]; then
            eprintf "_are_all_brackets_matched: bracket_counts[%s] is %d\n" "parenthesis" "${bracket_counts["parenthesis"]}"
            result="false"
            retval=1
        elif [[ ${bracket_counts["curly"]} -ne 0 ]]; then
            eprintf "_are_all_brackets_matched: bracket_counts[%s] is %d\n" "curly" "${bracket_counts["curly"]}"
            result="false"
            retval=1
        fi

        printf "%s" "${result}"
        return "${retval}"
    } # _are_all_brackets_matched()

    _show_bracket_counters()
    {
        local key

        eprintf "\n"
        for key in "${!bracket_counts[@]}"; do
            eprintf "bracket_counts[%s]=%d\n" "${key}" "${bracket_counts[${key}]}"
        done
        eprintf "\n"
    } # _show_bracket_counters()

    _bracket_counter()
    {
        local bracket="${1}"

        case ${bracket}  in
            "[")
                (( bracket_counts["square"]++ ))
                eprintf "_bracket_counter: square incremented to [%d]\n" "${bracket_counts["square"]}"
                ;;
            "]")
                (( bracket_counts["square"]-- ))
                eprintf "_bracket_counter: square decremented to [%d]\n" "${bracket_counts["square"]}"
                ;;
            "(")
                (( bracket_counts["parenthesis"]++ ))
                eprintf "_bracket_counter: parenthesis incremented to [%d]\n" "${bracket_counts["parenthesis"]}"
                ;;
            ")")
                (( bracket_counts["parenthesis"]-- ))
                eprintf "_bracket_counter: parenthesis decremented to [%d]\n" "${bracket_counts["parenthesis"]}"
                ;;
            "{")
                (( bracket_counts["curly"]++ ))
                eprintf "_bracket_counter: curly incremented to [%d]\n" "${bracket_counts["curly"]}"
                ;;
            "}")
                (( bracket_counts["curly"]-- ))
                eprintf "_bracket_counter: curly decremented to [%d]\n" "${bracket_counts["curly"]}"
                ;;
        esac

        _show_bracket_counters

        return 0
    } # _bracket_counter()

    _increment_index()
    {
        (( index++ ))
        eprintf "Incrementing index to [%d]\n" "${index}"
    } # _increment_index()

    _bracket_stack()
    {
        local cmd="${1}"
        local data="${2:-}"

        eprintf "Stack Before: \"%s\"\n" "${bracket_memory}"

        if [[ ${cmd} == push ]]; then
            bracket_memory+="${data}"
        elif [[ ${cmd} == pop ]]; then
            bracket_memory="${bracket_memory%?}"
        fi

        eprintf "Stack After : \"%s\"\n" "${bracket_memory}"
    } # _bracket_stack

    _find_next_bracket()
    {
        local previous_char
        local current_char
        local search_char

        local -i retval=0

        if [[ ${index} -ge ${#input} ]]; then
            eprintf "(end of input) return %d\n\n" 0
            (( recursion_level-- ))
            return 0
        fi

        (( recursion_level++ ))
        eprintf "\n"
        eprintf "_find_next_bracket: level is %d\n" "${recursion_level}"

        current_char="${input:${index}:1}"

        # Move the cursor to the next character.
        _increment_index

        if [[ ${current_char} =~ (\[|\(|\{) ]]; then
            eprintf "Found opening bracket \"%s\".\n" "${current_char}"

            # Increment the bracket counter.
            _bracket_counter "${current_char}"

            # Keep a list of opening brackets.
            _bracket_stack "push" "${current_char}"

        elif [[ ${current_char} =~ (\]|\)|\}) ]]; then

            # Get the right-most bracket from memory.
            previous_char="${bracket_memory: -1}"

            if [[ -z ${previous_char} ]]; then
                eprintf "(started with a closing bracket) return %d\n\n" 1
                _bracket_counter "${bracket_flipper[${current_char}]}"
                return 1
            fi

            # Set the search character to the opposite of the current character.
            search_char="${bracket_flipper[${previous_char}]}"

            eprintf "Looking at closing \"%s\", searching for \"%s\"\n" "${current_char}" "${search_char}"

            if [[ ${current_char} == "${search_char}" ]]; then
                    eprintf "Found next closing bracket \"%s\".\n" "${search_char}"

                    # Decrement the closing bracket counter.
                    _bracket_counter "${search_char}"

                    # Remove the matched bracket from memory.
                    _bracket_stack "pop"

            else
                eprintf "Found the wrong closing bracket \"%s\" while looking for the next opening bracket \"%s\".\n" "${current_char}" "${search_char}"
                _bracket_counter "${current_char}"

                eprintf "END: Terminating...\n"

                eprintf "(wrong closing bracket) return %d\n\n" 1
                return 1
            fi

        fi

        _find_next_bracket
        retval=$?

        eprintf "\tindex        = [%s]\n" "${index}"

        _show_bracket_counters

        # Success or failure.
        eprintf "(end of _find_next_bracket) return %d\n\n" "${retval}"
        (( recursion_level-- ))
        return ${retval}
    }

    _show_bracket_counters

    _find_next_bracket
    retval=$?

    if _are_all_brackets_matched > /dev/null; then
        eprintf "All of the brackets were matched.\n"
        retval=0
    else
        eprintf "Not all of the brackets were matched.\n"
        (( retval++ ))
    fi

    # So eprintf stops printing the recursion level.
    unset recursion_level

    eprintf "(end of find_next_bracket) return %d\n\n" "${retval}"
    return "${retval}"
} # find_next_bracket()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local input="${1}"

    if find_next_bracket "${input}"; then
        printf "%s\n" "true"
    else
        printf "%s\n" "false"
    fi
} # main()

# Run the main function.
main "${@}"
