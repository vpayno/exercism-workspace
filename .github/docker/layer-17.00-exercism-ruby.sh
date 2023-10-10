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

	echo Running: mv .rbenv /usr/local/rbenv
	time mv "${HOME}/.rbenv" /usr/local/rbenv || track_errors
	printf "\n"

	echo Running: ln -sv /usr/local/rbenv "${HOME}/.rbenv"
	ln -sv /usr/local/rbenv "${HOME}/.rbenv" || track_errors
	printf "\n"

	echo Running: ln -sv /usr/local/rbenv "/etc/skel/.rbenv"
	ln -sv /usr/local/rbenv "/etc/skel/.rbenv" || track_errors
	printf "\n"

	echo Checking installation:
	ls -lh /usr/local/ /usr/local/rbenv/ /root/.rbenv /etc/skel/.rbenv
	printf "\n"

	printf "Configuring Shell: "
	tee /etc/bashrc.d/ruby.sh <<-EOF
		#
		# /etc/bashrc.d/ruby.sh
		#

		export PATH="/usr/local/rbenv/bin:/usr/local/rbenv/bin/shims:\${PATH}"

		eval "\$(rbenv init -)"
	EOF
	printf "done\n"

	echo Running: source /etc/bashrc.d/ruby.sh
	# shellcheck disable=SC1091
	source /etc/bashrc.d/ruby.sh || track_errors
	printf "\n"

	layer_end "${0}" "$@"

	echo Running: return "${retval}"
	return "${retval}"
}

time main "${@}" |& tee /root/layer-17.00-exercism-ruby.log
