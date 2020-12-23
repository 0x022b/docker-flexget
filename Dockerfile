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
python3 -m pip install --upgrade pip wheel && \
apk add --no-cache --virtual pycurl-build \
    build-base \
    curl-dev \
    jpeg-dev \
    python3-dev && \
python3 -m pip install --no-cache-dir \
    'flexget<3.2' \
    'pycurl' \
    'transmissionrpc-ng' && \
python3 -m pip uninstall --yes pip wheel && \
apk del --no-cache pycurl-build && \
ln -s /etc/TZ /etc/timezone

COPY rootfs/ /
