#!/bin/bash
#
# .github/docker/layer-00.50-base-docker.sh
#

set -o pipefail

# this path from for the container
# shellcheck disable=SC1091
. /.github/docker/include

main() {
	declare -i retval=0

	layer_begin "${0}" "$@"

	local -a DEPS
	DEPS=(
		ca-certificates
		curl
		gnupg
	)

	local -a PACKAGES
	PACKAGES=(
		docker-ce
		docker-ce-cli
		containerd.io
		docker-buildx-plugin
		docker-compose-plugin
	)

	echo Running: apt update
	time apt update || track_errors
	printf "\n"

	echo Running: apt install -y "${DEPS[@]}"
	time apt install -y "${DEPS[@]}" || track_errors
	printf "\n"

	echo Running: install -m 0755 -d /etc/apt/keyrings
	install -m 0755 -d /etc/apt/keyrings || track_errors
	printf "\n"

	echo Running: curl -fsSL https://download.docker.com/linux/debian/gpg \| sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg || track_errors
	printf "\n"

	tee /etc/apt/sources.list.d/docker.list <<-EOF
		deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable
	EOF
	printf "\n"

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

main "${@}" |& tee "${HOME}"/layer-00.50-base-docker.log
