#!/bin/sh
#
# .github/docker/layer-00.00-base-dependencies.sh
#

# this path from for the container
# shellcheck disable=SC1091
. /.github/docker/include

main() {
	layer_begin "${0}" "$@"

	PACKAGES="apt-utils bash coreutils curl jq moreutils sudo tmux util-linux vim-nox"

	printf "Collecting apt installed packages:\n"
	echo Running: apt list --installed \> /root/apt-pkgs-start.txt
	apt list --installed >/root/apt-pkgs-start.txt
	printf "\n"

	echo apt install -y "${PACKAGES}"
	# shellcheck disable=SC2086
	apt install -y ${PACKAGES} || exit
	printf "\n"

	layer_end "${0}" "$@"
}

main "${@}" 2>&1 | tee /root/layer-00.00-base-dependencies.log
