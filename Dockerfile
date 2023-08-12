#
# Dockerfile: ci-generic-debian
#

From debian:bullseye-slim As ci-generic-base

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY .github/docker/entrypoint.sh /entrypoint.sh

# app + args
# Executes `entrypoint.sh` when the Docker container starts up
ENTRYPOINT ["/entrypoint.sh"]

# extra args
# CMD []
