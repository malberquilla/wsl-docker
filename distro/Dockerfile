FROM alpine:3.15.0

RUN apk upgrade -U
RUN apk add --no-cache shadow curl dpkg docker
RUN addgroup $(whoami) docker && groupmod -g 36257 docker

ARG DOCKER_DIR=/mnt/wsl/docker
RUN mkdir -pm o=,ug=rwx ${DOCKER_DIR} && chgrp docker ${DOCKER_DIR}
RUN touch ${DOCKER_DIR}/.empty

ENV ENV="/etc/profile"

COPY /config/profile /etc/profile
COPY /config/daemon.json /etc/docker/daemon.json

# Install docker compose v2
ARG DOCKER_CONFIG=${DOCKER_CONFIG:-root/.docker}
RUN mkdir -p $DOCKER_CONFIG/cli-plugins
RUN curl -L "https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-$(uname -s)-$(uname -m)" -o $DOCKER_CONFIG/cli-plugins/docker-compose
RUN chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

# Install compose-switch for v1-v2 compatibility
# Finds the latest version
#ARG switch_version=$(curl -fsSL -o /dev/null -w "%{url_effective}" https://github.com/docker/compose-switch/releases/latest | xargs basename)

# Downloads the binary
RUN curl -fL https://github.com/docker/compose-switch/releases/latest/download/docker-compose-linux-amd64 -o /usr/local/bin/docker-compose

# Assigns execution permission to it
RUN chmod +x /usr/local/bin/docker-compose
