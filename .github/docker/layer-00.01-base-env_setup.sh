#!/bin/sh
#
# .github/docker/layer-00.01-base-env_setup.sh
#

# this path from for the container
# shellcheck disable=SC1091
. /.github/docker/include

main() {
	layer_begin "${0}" "$@"

	echo Setting Up /etc/bashrc.d/ in /etc/bash.bashrc
	# borrowed this from /etc/profile
	tee -a /etc/bash.bashrc <<-EOF

		if [ -d /etc/bashrc.d ]; then
			for i in /etc/bashrc.d/\*.sh; do
				if [ -r \$i ]; then
					. \$i
				fi
		   done
		   unset i
		fi
	EOF
	printf "\n"

	echo Running: mkdir -pv /etc/bashrc.d/
	mkdir -pv /etc/bashrc.d/ || exit
	printf "\n"

	layer_end "${0}" "$@"
}

main "${@}" 2>&1 | tee /root/layer-00.01-base-env_setup.log
