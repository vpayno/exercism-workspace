#!/bin/bash
#
# .github/docker/layer-00.05-additional_deps.sh
#

set -o pipefail

# this path from inside the container
# shellcheck disable=SC1091
. /.github/docker/include

main() {
	declare -i retval=0

	layer_begin "${0}" "$@"

	echo Running: sudo apt update
	time sudo apt update || track_errors
	printf "\n"

	local PACKAGES
	PACKAGES=(
		libcurl4
		libcurl4-doc
		libcurl4-openssl-dev
		libcurlpp-dev
		libcurlpp0
		libfontconfig1-dev
		libfreetype6-dev
		libfribidi-dev
		libharfbuzz-dev
		libjpeg-dev
		libpng-dev
		libtiff5-dev
	)

	echo Running: sudo apt install -y "${PACKAGES[@]}"
	time sudo apt install -y "${PACKAGES[@]}" || track_errors
	printf "\n"

	layer_end "${0}" "$@"

	echo Running: return "${retval}"
	return "${retval}"
}

main "${@}" |& tee "${HOME}"/layer-00.05-additional_deps.log
