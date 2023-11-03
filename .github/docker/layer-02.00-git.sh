#!/bin/bash
#
# .github/docker/layer-02.00-git.sh
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
		gh
		git-all
		git-crypt
		git-extras
		gitlab-cli
		gitlint
	)

	echo Running: apt update
	time apt update || track_errors
	printf "\n"

	echo Running: apt install -y "${PACKAGES[@]}"
	time apt install -y "${PACKAGES[@]}" || track_errors
	printf "\n"

	layer_end "${0}" "$@"

	echo Running: return "${retval}"
	return "${retval}"
}

main "${@}" |& tee "${HOME}"/layer-02.00-git.log
