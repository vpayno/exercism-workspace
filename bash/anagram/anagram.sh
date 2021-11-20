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
    if [[ ${#vargs[@]} -ne 2 ]]; then
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

# Function: sort letters in string
# Input : string
# Output: sorted string
# Result: 0
sort_string()
{
    # Convert the string to lowercase to make comparisons easier and prevent sorting issues because of case.
    local string="${1,,}"

    # Only using :alpha: since that's the only character class the tests use.
    printf "%s" "$(tr -d '\n' <<< "$(sort <<< "$(printf "%s\n" "$(sed -r -e ' :restart ; s/([[:alpha:]])([[:alpha:]])/\1\n\2/ ; t restart ' <<< "${string}")")")")"
} # sort_string()

# Function: Find matching anagram(s) in candidate list and returns a list of matches.
# Input : word and candidate list
# Output: found matches list
# Return: 0
find_anagram_in_list()
{
    local word="${1}"
    shift 1
    local -a candidate_list=( "$@" )

    local sorted_word
    local candidate_word
    local sorted_candidate_word
    local -a matched_list

    # So let's test if a word is an anagram of another word by sorting the strings and seeing if they match.
    sorted_word="$(sort_string "${word}")"

    for candidate_word in "${candidate_list[@]}"; do
        sorted_candidate_word="$(sort_string "${candidate_word}")"

        eprintf "[[ \"%s\" == \"%s\" ]]\n" "${sorted_word}" "${sorted_candidate_word}"
        eprintf "[[ \"%s\" != \"%s\" ]]\n" "${word,,}" "${candidate_word,,}"

        if [[ ${sorted_word} == "${sorted_candidate_word}" ]] && [[ ${word,,} != "${candidate_word,,}" ]]; then
            matched_list+=( "${candidate_word}" )
            eprintf "Adding [%s] to the matched list.\n" "${candidate_word}"
        fi
    done

    printf "%s " "${matched_list[@]}"
} # find_anagram_in_list()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local word="${1}"

    # Pop the word from the arument list so we can easily save the candidate list.
    shift 1
    local -a candidate_list
    # We need to convert the space delimited string into an array.
    read -r -a candidate_list <<< "$@"

    local -a found_list

    read -r -a found_list <<< "$(find_anagram_in_list "${word}" "${candidate_list[@]}")"

    eprintf "\n"
    eprintf "Word          : [%s]\n" "${word}"

    eprintf "Candidate List: ["
    eprintf "%s " "${candidate_list[@]}"
    eprintf "]\n"

    eprintf "Found anagrams: ["
    eprintf "%s " "${found_list[@]}"
    eprintf "]\n"

    ${DEBUG} || {
        printf "%s " "${found_list[@]}"
    } | sed -r -e 's/ +$/\n/g'
} # main()

# Run the main function.
main "${@}"
