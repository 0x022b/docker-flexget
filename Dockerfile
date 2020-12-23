FROM alpine:3.12
LABEL maintainer="Janne K <0x022b@gmail.com>"

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/container-entrypoint"]
CMD ["container-daemon"]

RUN \
apk upgrade --no-cache && \
apk add --no-cache \
    ca-certificates \
    iptables \
    ip6tables \
    su-exec \
    tini

VOLUME ["/app"]

RUN \
apk add --no-cache \
    libcurl \
    python3 && \
python3 -m ensurepip && \
apk add --no-cache --virtual pycurl-build \
    build-base \
    curl-dev \
    jpeg-dev \
    python3-dev && \
pip3 install --no-cache-dir --disable-pip-version-check \
    'flexget<3.2' \
    'pycurl' \
    'transmissionrpc-ng' && \
apk del --no-cache pycurl-build && \
ln -s /etc/TZ /etc/timezone

COPY rootfs/ /
