#!/bin/bash
#
# .github/docker/layer-14.00-exercism-tools.sh
#

set -o pipefail

# this path from for the container
# shellcheck disable=SC1091
. /.github/docker/include

# shellcheck disable=SC1091
source /.github/citools/includes/wrapper-library || exit

main() {
	declare -i retval=0

	layer_begin "${0}" "$@"

	declare -a PACKAGES
	PACKAGES=(
		ansible-lint
		bats
		gitlint
		pgformatter
		shellcheck
		sqlformat
		xmlformat-perl
		yamllint
	)

	echo Running: apt install -y "${PACKAGES[@]}"
	time apt install -y "${PACKAGES[@]}" || track_errors
	printf "\n"

	layer_end "${0}" "$@"

	echo Running: return "${retval}"
	return "${retval}"
}

time main "${@}" |& tee "${HOME}"/layer-14.00-exercism-tools.log