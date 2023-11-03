#!/bin/bash
#
# .github/docker/layer-10.00-exercism-gcc_clang_llvm.sh
#

set -o pipefail

# https://apt.llvm.org/

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
		build-essential
		ccls
		clangd-16
		clang-16
		clang-16-doc
		clang-format-16
		clang-tidy-16
		clang-tools-16
		cmake
		gcc
		gcovr
		gettext
		gnu-standards
		g++
		lcov
		libboost-all-dev
		libclang1-16
		libclang-16-dev
		libclang-common-16-dev
		libclang-rt-16-dev
		libc++abi-16-dev
		libc++-16-dev
		libfuzzer-16-dev
		libllvm16
		libllvm-16-ocaml-dev
		libssl-dev
		libunwind-16-dev
		lldb-16
		lld-16
		llvm-16
		llvm-16-dev
		llvm-16-runtime
		make
		pkg-config
		python3-clang-16
	)

	# wget -q https://apt.llvm.org/llvm.sh
	# chmod -v +x llvm.sh
	# ./llvm.sh 16 all

	echo Creating /etc/apt/sources.list.d/llvm.list
	tee -a /etc/apt/sources.list.d/llvm.list <<-EOF
		# deb http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm main
		# deb-src http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm main
		# deb http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-14 main
		# deb-src http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-14 main
		# deb http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-15 main
		# deb-src http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-15 main
		deb http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-16 main
		deb-src http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-16 main
		# deb http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-17 main
		# deb-src http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-17 main
	EOF

	#wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
	echo Running: curl -sS https://apt.llvm.org/llvm-snapshot.gpg.key | tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc
	time curl -sS https://apt.llvm.org/llvm-snapshot.gpg.key | tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc || track_errors
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

main "${@}" |& tee "${HOME}"/layer-10.00-exercism-gcc_clang_llvm.log
