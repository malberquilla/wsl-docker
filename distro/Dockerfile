FROM alpine:3.15.0 as downloader
WORKDIR /tmp
RUN apk add --no-cache curl

ARG COMPOSE_VERSION=v2.3.3
RUN curl -L# "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o docker-compose && \
    curl -L# https://github.com/docker/compose-switch/releases/latest/download/docker-compose-linux-amd64 -o compose-switch

FROM alpine:3.15.0

RUN apk upgrade -U && \
    apk add --no-cache shadow docker

ARG DOCKER_GROUP_ID=36257    
RUN addgroup $(whoami) docker && groupmod -g ${DOCKER_GROUP_ID} docker

ARG DOCKER_DIR=/mnt/wsl/docker
RUN mkdir -pm o=,ug=rwx ${DOCKER_DIR} && chgrp docker ${DOCKER_DIR}

ENV ENV="/etc/profile"

COPY /config/profile /etc/profile
COPY /config/daemon.json /etc/docker/daemon.json

# Install docker compose v2
ARG DOCKER_CONFIG=${DOCKER_CONFIG:-root/.docker}
RUN mkdir -p $DOCKER_CONFIG/cli-plugins
COPY --from=downloader /tmp/docker-compose $DOCKER_CONFIG/cli-plugins/docker-compose
RUN chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

# Install compose-switch for v1-v2 compatibility
COPY --from=downloader /tmp/compose-switch /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
