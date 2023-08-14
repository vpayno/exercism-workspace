#!/bin/bash

# this path from for the container
# shellcheck disable=SC1091
. /.github/docker/include

layer_begin "$@"

declare -a PACKAGES
PACKAGES=(
	nodejs
	npm
)

apt update

echo apt install -y "${PACKAGES[@]}"
apt install -y "${PACKAGES[@]}" || exit
printf "\n"

echo npm install --global yarn
npm install --global yarn || exit
printf "\n"

layer_end "$@"
