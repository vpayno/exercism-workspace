#!/bin/bash

# https://apt.llvm.org/

# this path from for the container
# shellcheck disable=SC1091
. /.github/docker/include

layer_begin "$@"

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
	cargo-edit
	cargo-fix
	cargo-fuzz
	cargo-kcov
	cargo-llvm-cov
	cargo-tarpaulin
	grcov
	zellij
)

declare -a COMPONENTS
COMPONENTS=(
	clippy
	llvm-tools-x86_64-unknown-linux-gnu
	rustfmt
)

echo apt install -y "${PACKAGES[@]}"
apt install -y "${PACKAGES[@]}" || exit
printf "\n"

echo curl https://sh.rustup.rs -sSf \| bash -s -- -y
curl https://sh.rustup.rs -sSf | bash -s -- -y || exit
printf "\n"

# ENV PATH="/root/.cargo/bin:${PATH}"
printf "source %s\n" "${HOME}/.cargo/env" | tee -a "${HOME}/.bashrc"
source "${HOME}/.bashrc"

echo rustup default stable
time rustup default stable || exit
printf "\n"

echo rustc --version
rustc --version || exit
printf "\n"

export CARGO_REGISTRIES_CRATES_IO_PROTOCOL="sparse"

echo cargo install sccache
cargo install sccache || exit
printf "\n"

export RUSTC_WRAPPER="sccache"
echo RUSTC_WRAPPER="sccache" | tee -a "${HOME}/.bashrc"
printf "\n"

for component in "${COMPONENTS[@]}"; do
	echo rustup component add "${component}"
	time rustup component add "${component}" || exit
	printf "\n"
done

echo cargo install "${CRATES[@]}"
cargo install "${CRATES[@]}" || exit
printf "\n"

printf "Installed Rust components:\n"
echo rustup component list
time rustup component list
printf "\n"

printf "Installed Crates:\n"
echo cargo install --list
cargo install --list
printf "\n"

layer_end "$@"
