#!/bin/sh
#
# .github/docker/layer-00.00-base-dependencies.sh
#

# this path from for the container
# shellcheck disable=SC1091
. /.github/docker/include

main() {
	layer_begin "${0}" "$@"

	PACKAGES="apt-utils bash bsdextrautils coreutils curl jq moreutils sudo tmux util-linux vim-nox"

	printf "Collecting apt installed packages:\n"
	echo Running: apt list --installed \> /root/apt-pkgs-start.txt
	apt list --installed >/root/apt-pkgs-start.txt
	printf "\n"

	echo Running: apt remove -y "$(apt list --installed | grep -e xorg -e xserver -e qt | cut -f1 -d/)"
	# shellcheck disable=SC2046
	apt remove -y $(apt list --installed | grep -e xorg -e xserver -e qt | cut -f1 -d/) || exit
	printf "\n"

	echo Running: apt-get purge libx11.* libqt.*
	apt-get purge libx11.* libqt.* || exit
	printf "\n"

	echo Running: apt-get remove -y x11-common
	apt-get remove -y x11-common || exit
	printf "\n"

	echo apt install -y "${PACKAGES}"
	# shellcheck disable=SC2086
	apt install -y ${PACKAGES} || exit
	printf "\n"

	layer_end "${0}" "$@"
}

main "${@}" 2>&1 | tee /root/layer-00.00-base-dependencies.log
