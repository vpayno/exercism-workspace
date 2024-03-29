#!/bin/bash
#
# .github/docker/layer-19.00-exercism-r.sh
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

	echo Running: source /etc/profile.d/python.sh
	# shellcheck disable=SC1091
	source /etc/profile.d/python.sh || track_errors
	printf "\n"

	echo Running: /.github/citools/r/r-setup-install
	time /.github/citools/r/r-setup-install || track_errors
	printf "\n"

	echo Running: /.github/citools/r/r-setup-config
	time /.github/citools/r/r-setup-config || track_errors
	printf "\n"

	echo Adding source /etc/profile.d/r.sh to ~/.bashrc and /etc/skel/.bashrc
	echo '. /etc/profile.d/r.sh' | tee -a "${HOME}/.bashrc" | tee -a "${HOME}/.profile" | tee -a /etc/skel/.bashrc || track_errors
	printf "\n"

	echo Running: source /etc/profile.d/r.sh
	# shellcheck disable=SC1091
	source /etc/profile.d/r.sh || track_errors
	printf "\n"

	echo Running: chgrp -R adm /usr/local/lib/R/site-library
	time chgrp -R adm /usr/local/lib/R/site-library || track_errors
	printf "\n"

	echo Running: setfacl -RPdm g:adm:w /usr/local/lib/R/site-library
	time setfacl -RPdm g:adm:w /usr/local/lib/R/site-library || track_errors
	printf "\n"

	layer_end "${0}" "$@"

	echo Running: return "${retval}"
	return "${retval}"
}

time main "${@}" |& tee "${HOME}"/layer-19.00-exercism-r.log
