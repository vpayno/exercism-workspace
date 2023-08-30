#!/bin/sh

# this path from for the container
# shellcheck disable=SC1091
. /.github/docker/include

main() {
	layer_begin "$@"

	PACKAGES="apt-utils bash coreutils curl jq moreutils sudo tmux util-linux vim-nox"

	echo apt install -y "${PACKAGES}"
	# shellcheck disable=SC2086
	apt install -y ${PACKAGES} || exit
	printf "\n"

	layer_end "$@"
}

main "${@}" 2>&1 | tee /root/layer-00.00-base-dependencies.log
