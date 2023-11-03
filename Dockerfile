#
# Dockerfile
#

From debian:bullseye-slim As ci-generic-base

COPY .github/docker /.github/docker

COPY .github/citools/ /.github/citools/

RUN sh .github/docker/layer-00.00-base-dependencies.sh ci-generic-debian

RUN bash .github/docker/layer-00.01-base-env_setup.sh ci-generic-debian

RUN bash .github/docker/layer-00.10-base-daggerio.sh ci-generic-debian

RUN bash .github/docker/layer-09.00-exercism-nodejs.sh ci-generic-debian

RUN bash .github/docker/layer-10.00-exercism-gcc_clang_llvm.sh ci-generic-debian

RUN bash .github/docker/layer-15.00-exercism-rust.sh ci-generic-debian

RUN bash .github/docker/layer-16.00-exercism-go.sh ci-generic-debian

RUN bash .github/docker/layer-17.00-exercism-ruby.sh ci-generic-debian

RUN bash .github/docker/layer-99.00-summary.sh ci-generic-debian

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY .github/docker/entrypoint.sh /entrypoint.sh

RUN rm -rvf /.github

# app + args
# Executes `entrypoint.sh` when the Docker container starts up
ENTRYPOINT ["/entrypoint.sh"]

# Extra args
CMD []
