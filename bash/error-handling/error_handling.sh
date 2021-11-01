#!/usr/bin/env bash

declare -a vargs=( "$0" "$@" )
declare name="${1:-}"

show_usage()
{
    local script_name="${1:-${vargs[0]}}"

    printf "Usage: %s <person>\n" "${script_name}"
    exit 1
}

check_args()
{
    local -i retval=0
    local -i global_arg_count="(( "${#vargs[@]}" - 1 ))"

    if [[ ${global_arg_count} -ne 1 ]]; then
        (( retval++ ))
    fi

    return "${retval}"
}

check_args || show_usage

say_hello()
{
    local name="${1:-}"

    printf "Hello, %s\n" "${name}"
}

say_hello "${name}"