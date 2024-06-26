#
# Dockerfile
#

From debian:bookworm-slim As ci-base-debian

COPY .github/docker /.github/docker

COPY .github/citools/ /.github/citools/

RUN sh .github/docker/layer-00.00-base-dependencies.sh ci-base-debian && : 20240109-002

RUN bash .github/docker/layer-00.01-base-env_setup.sh ci-base-debian && : 20231103-000

RUN bash .github/docker/layer-00.05-additional_deps.sh ci-base-debian && : 20240329-000

RUN bash .github/docker/layer-00.10-base-daggerio.sh ci-base-debian && : 20231103-000

RUN bash .github/docker/layer-00.50-base-docker.sh ci-base-debian && : 20231228-000

RUN bash .github/docker/layer-02.00-git.sh ci-base-debian && : 20231103-000

RUN bash .github/docker/layer-09.00-exercism-nodejs.sh ci-base-debian && : 20231103-000

RUN bash .github/docker/layer-10.00-exercism-gcc_clang_llvm.sh ci-base-debian && : 20231103-000

RUN bash .github/docker/layer-14.00-exercism-tools.sh ci-base-debian && : 20240101-000

RUN bash .github/docker/layer-99.00-summary.sh ci-base-debian && : 20231103-000

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY .github/docker/entrypoint.sh /entrypoint.sh

RUN rm -rvf /.github

SHELL ["bash", "-c"]

# app + args
# Executes `entrypoint.sh` when the Docker container starts up
ENTRYPOINT ["/entrypoint.sh"]

# Extra args
CMD []

# =============================================================================

From ci-base-debian As ci-generic-debian

COPY .github/docker /.github/docker

COPY .github/citools/ /.github/citools/

RUN bash .github/docker/layer-15.00-exercism-rust.sh ci-generic-debian && : 20231103-000

RUN bash .github/docker/layer-16.00-exercism-go.sh ci-generic-debian && : 20240111-000

RUN bash .github/docker/layer-17.00-exercism-ruby.sh ci-generic-debian && : 20231103-000

RUN bash .github/docker/layer-18.00-exercism-python.sh ci-generic-debian && : 20240322-000

RUN bash .github/docker/layer-19.00-exercism-gleam.sh ci-generic-debian && : 20240322-000

RUN bash .github/docker/layer-25.00-tools-vscode.sh ci-generic-debian && : 20240102-000

RUN bash .github/docker/layer-35.00-tools-tailscale.sh ci-generic-debian && : 20240111-000

RUN bash .github/docker/layer-99.00-summary.sh ci-generic-debian && : 20231103-000

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY .github/docker/entrypoint.sh /entrypoint.sh

RUN rm -rvf /.github

SHELL ["bash", "-c"]

# app + args
# Executes `entrypoint.sh` when the Docker container starts up
ENTRYPOINT ["/entrypoint.sh"]

# Extra args
CMD []

# =============================================================================

From ci-base-debian As ci-anaconda-debian

COPY .github/docker /.github/docker

COPY .github/citools/ /.github/citools/

RUN bash .github/docker/layer-18.00-exercism-python.sh ci-anaconda-debian && : 20240322-000

RUN bash .github/docker/layer-20.00-exercism-r.sh ci-anaconda-debian && : 20240328-000

RUN bash .github/docker/layer-25.00-tools-vscode.sh ci-anaconda-debian && : 20240102-000

RUN bash .github/docker/layer-35.00-tools-tailscale.sh ci-anaconda-debian && : 20240111-000

RUN bash .github/docker/layer-99.00-summary.sh ci-anaconda-debian && : 20231103-000

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY .github/docker/entrypoint.sh /entrypoint.sh

RUN rm -rvf /.github

SHELL ["bash", "-c"]

# app + args
# Executes `entrypoint.sh` when the Docker container starts up
ENTRYPOINT ["/entrypoint.sh"]

# Extra args
CMD []
