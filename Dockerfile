FROM alpine:latest as base

RUN set -eux \
# Packages from testing
    && apk add \
        --no-cache \
        --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
# Docker tools
        gosu \
        tini

# Install the packages
RUN set -eux \
    && apk add --no-cache --virtual .build-deps \
        ca-certificates \
        curl \
        bash

    # Created user and group app
RUN set -eux \
    && addgroup -g 1000 app \
    && adduser -u 1000 -G app -H -D app \
    \
    && mkdir -p /app \
    && chown -R app:app /app

WORKDIR /home/app

COPY entrypoint-base.sh /sbin/docker-entrypoint.sh

ENTRYPOINT ["tini", "--", "/sbin/docker-entrypoint.sh"]

EXPOSE 3030