#!/bin/bash
#
# .github/docker/layer-16.00-exercism-go.sh
#

set -o pipefail

# https://apt.llvm.org/

# this path from for the container
# shellcheck disable=SC1091
. /.github/docker/include

golang_show_dl_urls() {
	curl -sS https://go.dev/dl/ | grep 'class="download"' | sed -r -e 's/^.*href="(.*)">.*$/https:\/\/go.dev\1/' | sort -V
} # golang_show_dl_urls()

golang_show_dl_versions() {
	golang_show_dl_urls | sed -r -e 's:^.*/go(.*)[.](zip|msi|tar.gz|pkg)$:\1:' | grep '[..]src$' | sed -r -e 's:[.]src::g' | grep -v -E '(beta|rc)' | sort -V
} # golang_show_dl_versions()

golang_install_latest() {
	local version

	version="$(golang_show_dl_versions | tail -n 1)"

	# was `go get golang.org/dl/gox.y.z`
	echo Running: go install golang.org/dl/go"${version}"@latest
	time go install golang.org/dl/go"${version}"@latest
	printf "\n"

	echo Running: go"${version}" download
	time go"${version}" download
	printf "\n"

	echo Checking Installed Go Version
	go version
	printf "\n"
} # golang_install_latest()

golang_first_install() {
	local GOARCH
	local GOVER

	if [[ ${HOSTTYPE} == x86_64 ]]; then
		GOARCH="amd64"
	elif [[ ${HOSTTYPE} == i686 ]]; then
		GOARCH="i386"
	elif [[ ${HOSTTYPE} == aarch64 ]]; then
		GOARCH="arm64"
	fi

	GOVER="$(golang_show_dl_versions | tail -n 1)"

	if go version >&/dev/null; then
		printf "%s is already installed\n" "$(go version)"
		printf "Use golang_install_latest to update go.\n"
		return 1
	fi

	printf "Installing Go version %s...\n\n" "${GOVER}"

	echo mkdir -v ~/.golang
	[[ -d ~/.golang ]] || mkdir -v ~/.golang

	echo curl -sS https://go.dev/dl/go"${GOVER}".linux-"${GOARCH}".tar.gz '|' tar -C ~/.golang/ -xzf -
	time curl -sS https://dl.google.com/go/go"${GOVER}".linux-"${GOARCH}".tar.gz | tar -C ~/.golang/ -xzf - || return 1
	printf "\n"

	#echo source "${HOME}"/.bashrc
	# shellcheck disable=SC1091
	#source "${HOME}"/.bashrc

	#PATH_OLD="${PATH}"
	PATH="${HOME}/.golang/go/bin:${PATH}"

	echo go version
	go version
	printf "\n"

	echo golang_install_latest
	time golang_install_latest
	printf "\n"

	#PATH="${PATH_OLD}"
} # golang_first_install()

main() {
	layer_begin "${0}" "$@"

	declare -i retval=0

	declare -a PACKAGES
	PACKAGES=(
	)

	declare -a CRATES
	CRATES=(
		github.com/appliedgocode/goman@latest
		github.com/client9/misspell/cmd/misspell@latest
		github.com/fzipp/gocyclo/cmd/gocyclo@latest
		github.com/get-woke/woke@latest
		github.com/go-critic/go-critic/cmd/gocritic@latest
		github.com/golangci/golangci-lint/cmd/golangci-lint@latest
		github.com/google/yamlfmt/cmd/yamlfmt@latest
		github.com/gordonklaus/ineffassign@latest
		github.com/goreleaser/goreleaser@latest
		github.com/govim/govim/cmd/govim@latest
		github.com/k1LoW/octocov@latest
		github.com/kisielk/errcheck@latest
		github.com/mgechev/revive@latest
		github.com/pelletier/go-toml/v2/cmd/jsontoml@latest
		github.com/pelletier/go-toml/v2/cmd/tomljson@latest
		github.com/pelletier/go-toml/v2/cmd/tomll@latest
		github.com/quasilyte/go-consistent@latest
		github.com/rakyll/gotest@latest
		github.com/reviewdog/reviewdog/cmd/reviewdog@latest
		github.com/rhysd/actionlint/cmd/actionlint@latest
		github.com/securego/gosec/v2/cmd/gosec@latest
		github.com/segmentio/golines@latest
		golang.org/x/lint/golint@latest
		golang.org/x/perf/cmd/benchstat@latest
		golang.org/x/tools/cmd/cover@latest
		golang.org/x/vuln/cmd/govulncheck@latest
		honnef.co/go/tools/cmd/staticcheck@latest
		mvdan.cc/gofumpt@latest
		mvdan.cc/sh/v3/cmd/shfmt@latest
	)

	declare -a GO_X_TOOLS
	GO_X_TOOLS=(
		auth/authtest
		auth/cookieauth
		auth/gitauth
		auth/netrcauth
		benchcmp
		bisect
		bundle
		callgraph
		compilebench
		digraph
		eg
		file2fuzz
		fiximports
		getgo
		go-contrib-init
		godex
		godoc
		goimports
		gomvpkg
		gonew
		gorename
		gotype
		goyacc
		guru
		html2article
		present
		present2md
		signature-fuzzer/fuzz-runner
		signature-fuzzer/fuzz-driver
		splitdwarf
		ssadump
		stress
		stringer
		toolstash
	)

	echo Running: apt install -y "${PACKAGES[@]}"
	time apt install -y "${PACKAGES[@]}" || exit
	printf "\n"

	cat >>"${HOME:-/root}/.bashrc" <<-EOF
		# go setup
		declare -x GOPATH
		declare -x GOBIN
		declare -x GOSRC
		declare -x PATH

		GOPATH="/root/go"
		GOBIN="/root/go/bin"
		GOSRC="/root/go/src"
		PATH="${PATH}:/root/.golang/go/bin:/root/go/bin"

		export GOPATH GOBIN GOSRC PATH

		if [[ ${HOSTTYPE} == x86_64 ]]; then
			export GOARCH="amd64"
		elif [[ ${HOSTTYPE} == i686 ]]; then
			export GOARCH="i386"
		elif [[ ${HOSTTYPE} == aarch64 ]]; then
			export GOARCH="arm64"
		fi
	EOF

	tee /etc/profile.d/go.sh <<-EOF
		#
		# /etc/profile.d/go.sh
		#

		export GOPATH="/usr/local/go"
		export GOBIN="\${GOPATH}/bin"
		export GOSRC="\${GOPATH}/src"
		export PATH="\${GOBIN}:\${PATH}"
	EOF

	echo Running: source /etc/profile.d/go.sh
	# shellcheck disable=SC1091
	source /etc/profile.d/go.sh || exit

	printf "PATH=%s\n" "${PATH}"
	printf "GOPATH=%s\n" "${GOPATH}"
	printf "GOBIN=%s\n" "${GOBIN}"
	printf "GOSRC=%s\n" "${GOSRC}"
	printf "\n"

	echo Running: golang_first_install
	time golang_first_install || exit
	printf "\n"

	echo Running: ls -lh /usr/local/go/{,bin}
	ls -lh /usr/local/go/{,bin}
	printf "\n"

	echo Running: go version
	go version || exit
	printf "\n"

	for go_x_tool in "${GO_X_TOOLS[@]}"; do
		echo Running: go install golang.org/x/tools/cmd/"${go_x_tool}"@latest
		time go install golang.org/x/tools/cmd/"${go_x_tool}"@latest || ((retval++))
		printf "\n"
	done

	for go_crate in "${CRATES[@]}"; do
		echo Running: go install "${go_crate}"
		time go install "${go_crate}" || ((retval++))
		printf "\n"
	done

	echo Running: go install -tags extended github.com/gohugoio/hugo@latest
	time go install -tags extended github.com/gohugoio/hugo@latest || ((retval++))
	printf "\n"

	echo Running: chgrp -R adm "${GOPATH}"
	chgrp -R adm "${GOPATH}" || exit

	echo Running: rm -rf /root/go/pkg/* /usr/local/go/pkg/*
	time rm -rf /root/go/pkg/* /usr/local/go/pkg/*
	printf "\n"

	echo Running: rm -rf /root/go/src/* /usr/local/go/src/*
	time rm -rf /root/go/src/* /usr/local/go/src/*
	printf "\n"

	layer_end "${0}" "$@"

	echo exit "${retval}"
	exit "${retval}"
}

time main "${@}" |& tee /root/layer-16.00-exercism-go.log
