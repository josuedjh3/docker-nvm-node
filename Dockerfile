FROM alpine:latest as base

# Install the packages-tools
RUN set -eux \
  && apk add --no-cache --virtual .build-deps \
    gosu \
    tini

# Install the packages
RUN set -eux \
    && apk add --no-cache --virtual .build-deps \
        ca-certificates \
        curl \
        bash \
        && rm -rf /var/cache/apk/*
 \
    # Created user and group app
RUN set -eux \
    && addgroup -g 1000 app \
    && adduser -u 1000 -G app -H -D app \
    \
    && mkdir -p /app \
    && chown -R app:app /app

WORKDIR /app

COPY docker-entrypoint.sh /sbin/docker-entrypoint.sh

ENTRYPOINT ["tini", "--", "/sbin/docker-entrypoint.sh"]
