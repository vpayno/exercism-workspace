#!/usr/bin/env bash

declare -i input="${1:-0}"

declare output

int2snd()
{
    local -i number="${1}"

    local -i retval=0
    local sounds

    if [[ $(( number % 3 )) -eq 0 ]]; then
        sounds+="Pling"
        (( retval++ ))
    fi

    if [[ $(( number % 5 )) -eq 0 ]]; then
        sounds+="Plang"
        (( retval++ ))
    fi

    if [[ $(( number % 7 )) -eq 0 ]]; then
        sounds+="Plong"
        (( retval++ ))
    fi

    if [[ ${retval} -gt 0 ]]; then
        printf "%s" "${sounds}"
        return 0
    else
        printf "%s" "${number}"
        return 1
    fi
}

output="$(int2snd "${input}")"

printf "%s\n" "${output}"
