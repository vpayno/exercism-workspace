#!/bin/bash

set -o pipefail

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

main() {
	apt update

	echo apt install -y "${PACKAGES[@]}"
	apt install -y "${PACKAGES[@]}" || exit
	printf "\n"

	echo npm install --global "${MODULES[@]}"
	npm install --global "${MODULES[@]}" || exit
	printf "\n"

	layer_end "$@"
}

main "${@}" |& tee /root/layer-02.20-exercism-nodejs.log
