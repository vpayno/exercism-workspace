#!/bin/bash

set -o pipefail

# this path from for the container
# shellcheck disable=SC1091
. /.github/docker/include

main() {
	layer_begin "$@"

	echo curl -sSfL https://releases.dagger.io/dagger/install.sh \| sh
	curl -sSfL https://releases.dagger.io/dagger/install.sh | sh || exit
	printf "\n"

	layer_end "$@"
}

main "${@}" |& tee /root/layer-00.10-base-daggerio.log
