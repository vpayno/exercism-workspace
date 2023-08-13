#
# Dockerfile
#

From debian:bullseye-slim As ci-generic-base

COPY .github/docker /.github/docker

RUN .github/docker/layer-00.00-base-dependencies.sh ci-generic-debian

RUN .github/docker/layer-00.10-base-daggerio.sh ci-generic-debian

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY .github/docker/entrypoint.sh /entrypoint.sh

RUN rm -rvf /.github

# app + args
# Executes `entrypoint.sh` when the Docker container starts up
ENTRYPOINT ["/entrypoint.sh"]

# Extra args
CMD []
