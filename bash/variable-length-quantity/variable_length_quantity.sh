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
    local command="${1,,}"      # lower case the string
    shift
    local -a data=( "${@^^}" )  # upper case the string

    # Variable used to track the return codes from each of the checks.
    local -i retval=0

    # Two or more arguments?
    if [[ ${#vargs[@]} -lt 2 ]]; then
        eprintf "ERROR: wrong number of arguments were passed [%s](%d)\n" "${vargs[*]}" "${#vargs[@]}"
        show_usage
        (( retval++ ))

    # First argument: Either encode or decode?
    elif [[ ! ${command} =~ ^(encode|decode)$ ]]; then
        eprintf "ERROR: command [%s] can either be encode or decode.\n" "${command}"
        # Apparently errors go to stdout.
        printf "ERROR: unknown subcommand [%s].\n" "${command}"
        show_usage
        (( retval++ ))

    # Remaining arguments: One or more bytes?
    elif [[ ! ${data[*]} =~ ^([0-9A-F][0-9A-F]?[[:blank:]]?)+$ ]]; then
        eprintf "ERROR: data [%s] needs to be bytes formated in hexadecimal.\n" "${data[*]}"
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
        printf "%s\n\n" "Encode and Decode data using Variable Length Quantity."
        printf "Usage: \n"
        printf "\tAll data is in hexadecimal (without 0x)\n\n"
        printf "\t%s %s %s\n" "$0" "encode" "2000"
        printf "\t%s %s %s\n" "$0" "decode" "C0 00"
        printf "\n"
    } >&2
} # show_usage()

# Check the inputs for validity and exit if the checks fail.
check_args "$@" || exit "$?"

# Function: binary to hexadecimal converter
# Input : binary number
# Output: hexadecimal number
# Return: 0
binary2hex()
{
    local binary="${1}"
    local -n __hex="${2}"

    if [[ ${binary} == "00000000" ]]; then
        __hex="00"
    else
        # BC doesn't output hex numbers as expected so we need to convert them
        # to decimal first and use printf to generate the hex number.
        eprintf "decimal=\"\$(bc <<< \"obase=10; ibase=2; %s\")\n" "${binary}"
        decimal="$(bc <<< "obase=10; ibase=2; ${binary}")"
        printf -v hex "%02x" "${decimal}"
        __hex="${__hex^^}"
    fi
} # binary2hex()

# Function: vlq encode
# Input : hexadecimal ints
# Output: hexadecimal encoded bytes
# Return: 0
vlq_encode()
{
    local -n __numbers="${1}"
    local -n __encoded_data="${2}"

    local number
    local binary
    local hex
    local -i decimal
    local -a words
    local byte
    local -i i

    eprintf "Numbers: [ "
    eprintf "%s " "${__numbers[@]}"
    eprintf "]\n\n"

    for number in "${__numbers[@]}"; do
        if [[ ${number} == "00" ]]; then
            __encoded_data+=( "00" )
            continue
        fi

        # Converts the hexadecimal number to a binary number.
        eprintf "binary=\"\$(bc <<< \"obase=2; ibase=16; %s\")\n" "${number}"
        binary="$(bc <<< "obase=2; ibase=16; ${number}")"

        eprintf "[%s](16) -> [%s](2)\n\n" "${number}" "${binary}"

        # This breaks up the binary number into 7-bit words.
        read -r -a words <<< "$(sed -r -e ' :restart ; s/([0-9])([0-9]{7})($|[^0-9])/\1 \2\3/ ; t restart ' <<< "${binary}")"

        eprintf "words=( "
        eprintf "%s " "${words[@]}"
        eprintf ")\n\n"

        for (( i=0; i<${#words[@]}; i++ )); do

            byte="${words[${i}]}"

            # zero-pad the first word
            if [[ ${i} -eq 0 ]]; then
                printf -v byte "%07d" "${byte}"
            fi

            eprintf "7-bit: [ %s]\n" "${byte}"

            # All but the last byte have bit 8 set to 1.
            if (( i+1 == ${#words[@]} )); then
                byte="0${byte}"
            else
                byte="1${byte}"
            fi

            eprintf "8-bit: [%s]\n" "${byte}"

            binary2hex "${byte}" "hex"

            eprintf "[%s](2) -> [%s](10) -> [%s](16)\n" "${byte}" "${decimal}" "${hex}"

            __encoded_data+=( "${hex}" )

            eprintf "\n"
        done
    done
} # vlq_encode()

# Function: vlq decode
# Input : hexadecimal encoded bytes
# Output: hexadecimal ints
# Return: 0
vlq_decode()
{
    local -n __vlq_data="${1}"
    local -n __decoded_data="${2}"

    local vlq
    local binary
    local hex
    local -i decimal
    local -a words
    local number
    local -i i
    local -i index=0
    local -i msb
    local -a bytes
    local byte
    local bits
    local register

    # 1. Take the VLQ, convert it to an 8-bit binary number.
    # 2. Take the MSB.
    # 3. Take the 7-bit number and save it.
    # 4. If the MSB is 1, keep collecting VLQs, stop if it's 0.

    for (( index=0; index<${#__vlq_data[@]}; index++ )); do
        vlq="${__vlq_data[${index}]}"

        if [[ ${vlq} == "00" ]]; then
            binary="00000000"
        else
            # Converts the hexadecimal number to a binary number.
            eprintf "binary=\"\$(bc <<< \"obase=2; ibase=16; %s\")\n" "${vlq}"
            binary="$(bc <<< "obase=2; ibase=16; ${vlq}")"
            printf -v binary "%08d" "${binary}"
        fi

        eprintf "[%s](16) -> [%s](2)\n" "${vlq}" "${binary}"

        msb="${binary:0:1}"
        bits="${binary:1}"
        register+="${bits}"

        printf -v bits "%08d" "${bits}"

        eprintf "msb=[%s]\n" "${msb}"
        eprintf "7-bits=[%s]\n" "${bits}"

        # Is the last VLQ for this number?
        if [[ ${msb} -eq 0 ]]; then
            eprintf "Completed bits: [%s]\n" "${register}"

            bytes+=( "${register}" )
            bits=""
            register=""
        fi

        eprintf "\n"
    done

    if [[ ${msb} -ne 0 ]]; then
        # Apparently errors belong in stdout, not stderr.
        printf "ERROR: incomplete byte sequence in [%s]\n" "${__vlq_data[*]}"
        exit 1
    fi

    register=""
    for byte in "${bytes[@]}"; do
        # Trim leading zeros from the Byte.
        byte="$(sed -r -e 's/^0+([0-9A-F]+)$/\1/g' <<< "${byte}")"

        # This breaks up the binary number into 8-bit words.
        read -r -a words <<< "$(sed -r -e ' :restart ; s/([0-9])([0-9]{8})($|[^0-9])/\1 \2\3/ ; t restart ' <<< "${byte}")"

        eprintf "words=( "
        eprintf "%s " "${words[@]}"
        eprintf ")\n\n"

        for word in "${words[@]}"; do
            # %d in printf will treat any numbers starting with 0 as octal so we need to strip them.
            word="$(sed -r -e 's/^0+([0-9A-F]+)$/\1/g' <<< "${word}")"
            printf -v word "%08d" "${word}"

            eprintf "8-bit: [%s]\n" "${word}"

            binary2hex "${word}" "hex"

            eprintf "[%s](2) -> [%s](10) -> [%s](16)\n" "${word}" "${decimal}" "${hex}"

            eprintf "Decoded int: [%s]\n" "${hex}"

            register="${register}${hex}"

            eprintf "\n"
        done

        # Trim leading zeros from the register.
        # Apparently "00" is ok (0 can have a leading zero).
        if [[ ${register} != "00" ]]; then
            register="$(sed -r -e 's/^0+([0-9A-F]+)$/\1/g' <<< "${register}")"
        fi

        __decoded_data+=( "${register}" )
        eprintf "Adding [%s] to __decoded_data=[%s].\n" "${register}" "${__decoded_data[*]}"
        register=""
    done
} # vlq_decode()

# Function: main function
# Input : script argument(s)
# Output: exercise output
# Return: 0
main()
{
    local command="${1,,}"
    shift
    local -a terms=( "${@^^}" )

    local word
    local -a data

    eprintf "\n"
    eprintf "Command: [%s]\n" "${command}"
    eprintf "\n"

    eprintf "Input  : [ "
    eprintf "%s " "${terms[@]}"
    eprintf "]\n\n"

    if [[ ${command} == encode ]]; then
        # The terms and data arrays are passed by reference (local -n __xxxxx).
        vlq_encode "terms" "data"
        eprintf "[%s] ->encode-> [%s]\n" "${terms[*]}" "${data[*]}"
    else
        # The terms and data arrays are passed by reference (local -n __xxxxx).
        vlq_decode "terms" "data"
        eprintf "[%s] ->decode-> [%s]\n" "${terms[*]}" "${data[*]}"
    fi

    ${DEBUG} || printf "%s\n" "${data[*]}"
} # main()

# Run the main function.
main "${@}"
