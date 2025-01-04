#!/usr/bin/env bash

set -x
set -e

# shellcheck disable=SC1091 source=.devcontainer/scripts/data.tmp
source /workspaces/exercism-workspace/.devcontainer/scripts/data.tmp

# shellcheck disable=SC2154
{
	groupadd --gid "${devcontainer_gid}" "${devcontainer_username}"
	useradd --uid "${devcontainer_uid}" --gid "${devcontainer_gid}" --no-create-home --groups docker "${devcontainer_username}"
	chsh --shell /bin/bash "${devcontainer_username}"
	printf "%s\n%s\n" "${devcontainer_password}" "${devcontainer_password}" | passwd "${devcontainer_username}"
	id "${devcontainer_username}"
}

declare -a cargo_pkgs=(
	bacon
	cargo-fuzz
	cargo-generate
	cargo-scaffold
	cargo-spellcheck
	git-cliff
	irust
	ripgrep
)

# these commands also run as root

cargo install --locked "${cargo_pkgs[@]}"
printf "\n"

rustup component add rust-analyzer
printf "\n"
