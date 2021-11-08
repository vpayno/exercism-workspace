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

# BC: Arbitrary precision calculator language: https://www.gnu.org/software/bc/manual/html_mono/bc.html

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
    local command="${1,,}"  # lowercase the string

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # One or Two arguments?
    if [[ ${#vargs[@]} -lt 1 ]] || [[ ${#vargs[@]} -gt 2 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # First argument: Either modifier or generate?
    elif [[ ! ${command} =~ ^(modifier|generate)$ ]]; then
        eprintf "ERROR: command [%s] can either be modifier or generate.\n" "${command}"
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

# Function: generates a pseudo-random dice roll
# Input : number of dice, number of sides
# Output: newline separated list of roll(s)
# Return: 0 (unused)
dice_roll()
{
    local -i number_of_dice="${1:-1}"
    local -i number_of_sides="${2:-6}"

    local -a rolls

    # You can use _ as a throwaway variable.
    for _ in $(seq 1 "${number_of_dice}"); do
        # If #sides is 12, the values returned will range from 0 to 11, so shift them by 1.
        rolls+=( $(( (RANDOM % number_of_sides) + 1 )) )
    done

    eprintf "Roll(s): [ "; eprintf "%s " "${rolls[@]}"; eprintf " ]\n"
    printf "%s\n" "${rolls[@]}" | sort -r -n
} # dice_roll()

# Function: generates a D&D character's constitution modifier (floor(constitution-10)/2))
# Input : character constitutiona
# Output: character constitution modifier
# Return: 0 (ok), 1 (fail)
get_constitution_modifier()
{
    local -i constitution="${1}"

    # Constitution can't be less than 3.
    if [[ ${constitution} -lt 3 ]]; then
        # Using $1 here since constitution converts strings to 0.
        eprintf "ERROR: get_constitution_modifier(): constitution input [%s] can't be less than 3.\n" "${1}"
        return 1
    fi

    local -i modifier

    # Don't forget that negative numbers are rounded down so -3.5 becomes -4.0.
    modifier="$(bc <<< "scale=4; c=((${constitution} - 10) / 2); if (c<0) c-=0.5; scale=0; c/1")"

    eprintf "Constitution [%d] => Modifier: [%d]\n" "${constitution}" "${modifier}"
    eprintf "\n"
    printf "%d" "${modifier}"
} # get_constitution_modifier()

# Function: calculate hitpoints
# Input : constitution modifier, base hitpoints (default is 10)
# Output: hitpoints
# Return: 0
get_hitpoints()
{
    local -i modifier="${1}"
    local -i base_hitpoints="${2:-10}"

    local -i hitpoints

    (( hitpoints=(base_hitpoints - modifier) ))

    eprintf "Base Hitpoints       : [%d]\n" "${base_hitpoints}"
    eprintf "Constitution Modifier: [%d]\n" "${modifier}"
    eprintf "Hitpoints            : [%d]\n" "${hitpoints}"
    eprintf "\n"

    printf "%d" "${hitpoints}"
} # get_hitpoints()

# Function: generate random character abilities
# Input : none
# Output: assosiative array/dictionary with strength, dexterity, constitution, intelligence, wisdom and charisma abilities
# Return: 0
get_abilities()
{
    local -i dice_count="${1}"
    local -i dice_sides="${2}"

    local ability
    local -i value

    # This would be declared in the scope the function is called from using eval.
    eprintf "%s\n" "local -A abilities"
    printf "%s\n" "local -A abilities"

    for ability in strength dexterity constitution intelligence wisdom charisma; do
        # Get the 3 dice rolls and sum them.
        value="$(dice_roll "${dice_count}" "${dice_sides}" | head -n $(( dice_count - 1 )) | paste -s -d+ - | bc)"

        eprintf "abilities[\"%s\"]=\"%s\"\n" "${ability}" "${value}"
        printf "abilities[\"%s\"]=\"%s\"\n" "${ability}" "${value}"
    done
} # get_abilities()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local command="${1,,}"
    local -i constitution="${2:-}"

    local -i modifier

    if [[ ${command} == "generate" ]]; then
        local -i dice_count=4
        local -i dice_sides=6
        local -i base_hitpoints=10

        local ability

        # This will return the assosiative array (dictionary) of the character abilities.
        # shellcheck disable=SC2046
        eval $(get_abilities "${dice_count}" "${dice_sides}")

        # Use the constitution ability to calculate the constitution modifier.
        modifier="$(get_constitution_modifier "${abilities[constitution]}")"

        # use the constitution modifier to calculate the hitpoints.
        abilities["hitpoints"]="$(get_hitpoints "${modifier}" "${base_hitpoints}")"

        # Get a list of the ability names and print the abilities.
        for ability in "${!abilities[@]}"; do
            printf "%s %d\n" "${ability}" "${abilities[${ability}]}"
        done
    else
        modifier="$(get_constitution_modifier "${constitution}")"
        eprintf "Constitution modifier: [%s]\n" "${modifier}"
        ${DEBUG} || printf "%s\n" "${modifier}"
    fi
} # main()

# Run the main function.
main "${@}"
