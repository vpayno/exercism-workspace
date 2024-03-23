#!/bin/bash
#
# .github/docker/layer-19.00-exercism-gleam.sh
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

	export ERLANG_ROOT="/usr/local/erlang"
	export REBAR3_ROOT="/usr/local/rebar3"

	echo Running: /.github/citools/gleam/gleam-setup-install
	time /.github/citools/gleam/gleam-setup-install || track_errors
	printf "\n"

	echo Running: /.github/citools/gleam/gleam-setup-config
	time /.github/citools/gleam/gleam-setup-config || track_errors
	printf "\n"

	echo Running: mkdir -pv /etc/skel/.cache
	mkdir -pv /etc/skel/.cache || track_errors
	printf "\n"

	echo Running: ln -sv "${REBAR3_ROOT}" "/etc/skel/.cache/rebar3"
	ln -sv "${REBAR3_ROOT}" "/etc/skel/.cache/rebar3" || track_errors
	printf "\n"

	echo Checking installation:
	ls -lh /usr/local/ "${ERLANG_ROOT}" "${REBAR3_ROOT}" "${HOME}"/.config /etc/skel/.config
	printf "\n"

	echo Adding source /etc/profile.d/gleam.sh to ~/.bashrc and /etc/skel/.bashrc
	echo '. /etc/profile.d/gleam.sh' | tee -a "${HOME}/.bashrc" | tee -a "${HOME}/.profile" | tee -a /etc/skel/.bashrc || track_errors
	printf "\n"

	echo Running: source /etc/profile.d/gleam.sh
	# shellcheck disable=SC1091
	source /etc/profile.d/gleam.sh || track_errors
	printf "\n"

	echo Running: chgrp -R adm "${ERLANG_ROOT}" "${REBAR3_ROOT}"
	time chgrp -R adm "${ERLANG_ROOT}" "${REBAR3_ROOT}" || track_errors
	printf "\n"

	echo Running: setfacl -RPdm g:adm:w "${ERLANG_ROOT}" "${REBAR3_ROOT}"
	time setfacl -RPdm g:adm:w "${ERLANG_ROOT}" "${REBAR3_ROOT}" || track_errors
	printf "\n"

	echo Running: rm -rf "${HOME}/git_remote/*"
	time rm -rf "${HOME}/git_remote/*"
	printf "\n"

	layer_end "${0}" "$@"

	echo Running: return "${retval}"
	return "${retval}"
}

time main "${@}" |& tee "${HOME}"/layer-19.00-exercism-gleam.log
