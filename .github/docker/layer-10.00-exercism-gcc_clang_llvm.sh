#!/bin/bash
#
# .github/docker/layer-10.00-exercism-gcc_clang_llvm.sh
#

set -o pipefail

# https://apt.llvm.org/

# this path from for the container
# shellcheck disable=SC1091
. /.github/docker/include

main() {
	layer_begin "$@"

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

	tee -a /etc/apt/sources.list <<EOF
# deb http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye main
# deb-src http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye main
# deb http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye-14 main
# deb-src http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye-14 main
# deb http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye-15 main
# deb-src http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye-15 main
deb http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye-16 main
deb-src http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye-16 main
# deb http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye-17 main
 #deb-src http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye-17 main
EOF

	#wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
	curl -sS https://apt.llvm.org/llvm-snapshot.gpg.key | tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc

	apt update

	echo apt install -y "${PACKAGES[@]}"
	apt install -y "${PACKAGES[@]}" || exit
	printf "\n"

	layer_end "$@"
}

main "${@}" |& tee /root/layer-10.00-exercism-gcc_clang_llvm.log
