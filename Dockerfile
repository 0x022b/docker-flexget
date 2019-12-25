FROM alpine:3.11
LABEL maintainer="Janne K <0x022b@gmail.com>"

ENTRYPOINT ["docker-entrypoint"]
CMD ["container-daemon"]
VOLUME ["/app"]

RUN \
apk upgrade --no-cache && \
apk add --no-cache \
    ca-certificates \
    iptables \
    ip6tables \
    libcurl \
    py3-pip \
    su-exec && \
apk add --no-cache --virtual pycurl-build \
    build-base \
    curl-dev \
    python3-dev && \
pip3 install --no-cache-dir --disable-pip-version-check \
    'flexget<3.1' \
    'pycurl' \
    'transmissionrpc-ng' && \
apk del --no-cache pycurl-build && \
ln -s /etc/TZ /etc/timezone

COPY rootfs/ /
