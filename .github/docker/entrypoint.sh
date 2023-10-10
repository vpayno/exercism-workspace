#!/bin/sh

# https://docs.github.com/en/actions/creating-actions/dockerfile-support-for-github-actions

# `$#` expands to the number of arguments and `$@` expands to the supplied `args`
printf "Starting container entrypoint.sh:\n"
printf "\t%d args: [" "$#"
printf " '%s'" "$@"
printf "]\n"

"$@"
