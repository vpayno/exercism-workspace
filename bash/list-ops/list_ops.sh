#!/usr/bin/env bash

# https://google.github.io/styleguide/shellguide.html#function-names
# https://www.gnu.org/software/bash/manual/html_node/Shell-Parameters.html

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    echo "This library of functions should be sourced into another script" >&2
    exit 4
fi
bash_version=$((10 * BASH_VERSINFO[0] + BASH_VERSINFO[1]))
if (( bash_version < 43 )); then
    echo "This library requires at least bash version 4.3" >&2
    return 4
fi

# Due to inherent bash limitations around word splitting and globbing,
# functions that are intended to *return a list* are instead required to
# receive a nameref parameter, the name of an array variable that will be
# populated in the list function.
# See the filter, map and reverse functions.

# Also note that nameref parameters cannot have the same name as the
# name of the variable in the calling scope.


# Append some elements to the given list.
list::append () {
    local -n __list1="${1}"
    shift

    __list1=( "${__list1[@]}" "$@" )
}

# Return only the list elements that pass the given function.
list::filter () {
    local -n __list2="${2}"
    local -n __result2="${3}"

    local item

    for item in "${__list2[@]}"; do
        if ${1} "${item}"; then
            __result2+=( "${item}" )
        fi
    done
}

# Transform the list elements, using the given function,
# into a new list.
list::map () {
    local -n __list3="${2}"
    local -n __result3="${3}"

    local item

    for item in "${__list3[@]}"; do
        __result3+=( "$(${1} "${item}")" )
    done
}

# Left-fold the list using the function and the initial value.
list::foldl () {
    local acc="${2}"
    local -n __list4="${3}"

    local item

    for item in "${__list4[@]}"; do
        acc="$(${1} "${acc}" "${item}")"
    done

    printf "%s\n" "${acc}"
}

# Right-fold the list using the function and the initial value.
list::foldr () {
    local acc="${2}"
    local -n __list5="${3}"

    local item
    local -a revlist5

    list::reverse __list5 revlist5

    for item in "${revlist5[@]}"; do
        acc="$(${1} "${item}" "${acc}")"
    done

    printf "%s\n" "${acc}"
}

# Return the list reversed
list::reverse () {
    local -n __list6="${1}"
    local -n __result6="${2}"

    local -i index

    for (( index="${#__list6[@]} - 1"; index >= 0; index-- )); do
        __result6+=( "${__list6[${index}]}" )
    done
}
