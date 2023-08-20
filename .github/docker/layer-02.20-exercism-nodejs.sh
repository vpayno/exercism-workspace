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

declare -a MODULES
MODULES=(
	json2yaml
	yarn
)

apt update

echo apt install -y "${PACKAGES[@]}"
apt install -y "${PACKAGES[@]}" || exit
printf "\n"

echo npm install --global "${MODULES[@]}"
npm install --global "${MODULES[@]}" || exit
printf "\n"

layer_end "$@"
