#!/bin/sh

# https://docs.github.com/en/actions/creating-actions/dockerfile-support-for-github-actions

# shellcheck disable=SC1091
# Setup the enviroment. Note: ${HOME} isn't available yet.
. "/root/.bashrc"
printf "\n"

# `$#` expands to the number of arguments and `$@` expands to the supplied `args`
printf "Starting container entrypoint.sh:\n"
printf "\t%d args: [" "$#"
printf " '%s'" "$@"
printf "]\n"

"$@"
