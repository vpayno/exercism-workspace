#!/bin/bash
#
# .github/docker/layer-15.00-exercism-rust.sh
#

set -o pipefail

# https://apt.llvm.org/

# this path from for the container
# shellcheck disable=SC1091
. /.github/docker/include

main() {
	layer_begin "${0}" "$@"

	declare -a PACKAGES
	PACKAGES=(
		clang-16
		clang-tidy-16
		clang-tools-16
		cmake
		g++
		gcovr
		lcov
		libllvm-16-ocaml-dev
		libllvm16
		libssl-dev
		lld-16
		llvm-16
		llvm-16-dev
		llvm-16-doc
		llvm-16-examples
		llvm-16-runtime
	)

	declare -a CRATES
	CRATES=(
		cargo-audit
		cargo-cache
		cargo-deps
		cargo-deps-list
		cargo-edit
		cargo-fix
		cargo-fuzz
		cargo-kcov
		cargo-llvm-cov
		cargo-tarpaulin
		clippy-sarif
		grcov
		sarif-fmt
		spellcheck
		strip-ansi-cli
		zellij
	)

	declare -a COMPONENTS
	COMPONENTS=(
		clippy
		llvm-tools-x86_64-unknown-linux-gnu
		rustfmt
	)

	echo Running: apt install -y "${PACKAGES[@]}"
	time apt install -y "${PACKAGES[@]}" || exit
	printf "\n"

	tee /etc/bashrc.d/rust.sh <<-EOF
		#
		# /etc/bashrc.d/rust.sh
		#

		export RUSTUP_HOME="/usr/local/rustup"
		export RUSTPATH="/usr/local/cargo"
		export CARGO_HOME="\${RUSTPATH}"
		export RUSTBIN="\${RUSTPATH}/bin"
		export PATH="\${RUSTBIN}:\${PATH}"
		export CARGO_REGISTRIES_CRATES_IO_PROTOCOL="sparse"
	EOF

	echo Running: source /etc/bashrc.d/rust.sh
	# shellcheck disable=SC1091
	source /etc/bashrc.d/rust.sh || exit

	printf "PATH=%s\n" "${PATH}"
	printf "RUSTUP_HOME=%s\n" "${RUSTUP_HOME}"
	printf "RUSTPATH=%s\n" "${RUSTPATH}"
	printf "CARGO_HOME=%s\n" "${CARGO_HOME}"
	printf "RUSTBIN=%s\n" "${RUSTBIN}"
	printf "CARGO_REGISTRIES_CRATES_IO_PROTOCOL=%s\n" "${CARGO_REGISTRIES_CRATES_IO_PROTOCOL}"
	printf "\n"

	echo Running: curl https://sh.rustup.rs -sSf \| bash -s -- -y
	time curl https://sh.rustup.rs -sSf | bash -s -- -y || exit
	printf "\n"

	echo Running: chgrp -R adm "${RUSTUP_HOME}"
	chgrp -R adm "${RUSTUP_HOME}" || exit

	echo Running: chgrp -R adm "${CARGO_HOME}"
	chgrp -R adm "${CARGO_HOME}" || exit

	echo Running: rustup install stable
	time rustup install stable || exit
	printf "\n"

	echo Running: rustup default stable
	time rustup default stable || exit
	printf "\n"

	echo Running: rustc --version
	rustc --version || exit
	printf "\n"

	echo Running: cargo install sccache
	time cargo install sccache || exit
	printf "\n"

	# this has to be added to the environment after sccache is installed
	export RUSTC_WRAPPER="sccache"
	echo export RUSTC_WRAPPER="sccache" | tee -a /etc/bashrc.d/rust.sh
	printf "\n"

	echo Running: sccache --start-server
	time sccache --start-server
	printf "\n"

	for component in "${COMPONENTS[@]}"; do
		echo Running: rustup component add "${component}"
		time rustup component add "${component}" || exit
		printf "\n"
	done

	echo Running: cargo install "${CRATES[@]}"
	time cargo install "${CRATES[@]}" || exit
	printf "\n"

	printf "Installed Rust components:\n"
	echo Running: rustup component list
	time rustup component list
	printf "\n"

	printf "Installed Crates:\n"
	echo Running: cargo install --list
	time cargo install --list
	printf "\n"

	printf "Show Rust Configuration:\n"
	echo Running: rustup show
	time rustup show
	printf "\n"

	printf "Show Rust sccache Info:\n"
	echo Running: sccache --show-stats
	sccache --show-stats
	printf "\n"

	printf "Show Rust Cache Info:\n"
	echo Running: cargo cache --info
	cargo cache --info
	printf "\n"

	echo Running: rm -rf /root/.cargo/registry/ /usr/local/cargo/registry/
	time rm -rf /root/.cargo/registry/ /usr/local/cargo/registry/
	printf "\n"

	layer_end "${0}" "$@"
}

time main "${@}" |& tee /root/layer-15.00-exercism-rust.log
