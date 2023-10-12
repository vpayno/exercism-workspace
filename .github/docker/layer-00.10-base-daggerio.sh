#!/bin/bash
#
# .github/docker/layer-00.10-base-daggerio.sh
#

set -o pipefail

# this path from for the container
# shellcheck disable=SC1091
. /.github/docker/include

main() {
	layer_begin "${0}" "$@"

	echo curl -sSfL https://releases.dagger.io/dagger/install.sh \| sh
	curl -sSfL https://releases.dagger.io/dagger/install.sh | sh || exit
	printf "\n"

	layer_end "${0}" "$@"
}

main "${@}" |& tee "${HOME}"/layer-00.10-base-daggerio.log
