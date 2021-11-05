#!/usr/bin/env bash

twofer() {
    local name="${1:-you}"
    printf "One for %s, one for me.\n" "${name}"
}

twofer "$@"
