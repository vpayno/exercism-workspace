#!/bin/bash
#
# .github/docker/layer-17.00-exercism-ruby.sh
#

set -o pipefail

# https://apt.llvm.org/

# this path from for the container
# shellcheck disable=SC1091
. /.github/docker/include

main() {
	declare -i retval=0

	layer_begin "${0}" "$@"

	echo Running: /.github/citools/ruby/ruby-setup-install
	time /.github/citools/ruby/ruby-setup-install || track_errors
	printf "\n"

	echo Running: /.github/citools/ruby/ruby-setup-config
	time /.github/citools/ruby/ruby-setup-config || track_errors
	printf "\n"

	printf "Configuring Shell: "
	tee /etc/bashrc.d/ruby.sh <<-EOF
		#
		# /etc/bashrc.d/ruby.sh
		#

		export PATH="\${HOME}/.rbenv/bin:\${HOME}/.rbenv/bin/shims:\${PATH}"

		eval "\$(rbenv init -)"
	EOF
	printf "done\n"

	echo Running: source /etc/bashrc.d/ruby.sh
	# shellcheck disable=SC1091
	source /etc/bashrc.d/ruby.sh || ((retval++))
	printf "\n"

	layer_end "${0}" "$@"

	echo Running: exit "${retval}"
	exit "${retval}"
}

time main "${@}" |& tee /root/layer-16.00-exercism-go.log
