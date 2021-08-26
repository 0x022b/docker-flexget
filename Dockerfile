FROM alpine:3.14
LABEL maintainer="Janne K <0x022b@gmail.com>"

ENTRYPOINT ["/sbin/tini", "-g", "--", "/usr/local/bin/container-entrypoint"]
CMD ["container-daemon"]

RUN \
sed -i 's/http:/https:/' /etc/apk/repositories && \
apk upgrade --no-cache && \
apk add --no-cache \
    ca-certificates \
    iptables \
    ip6tables \
    su-exec \
    tini \
    tzdata && \
ln -s /usr/share/zoneinfo/Universal /etc/localtime

VOLUME ["/app"]

RUN \
apk add --no-cache \
    libcurl \
    libstdc++ \
    python3 && \
python3 -m ensurepip && \
python3 -m pip install --no-cache-dir --upgrade pip wheel && \
apk add --no-cache --virtual build-deps \
    build-base \
    curl-dev \
    jpeg-dev \
    linux-headers \
    python3-dev && \
python3 -m pip install --no-cache-dir \
    'flexget<3.2' \
    'pycurl' \
    'transmission-rpc' \
    'transmissionrpc-ng' && \
python3 -m pip uninstall --no-cache-dir --yes pip wheel && \
apk del --no-cache build-deps && \
rm -rf /root/.cache

COPY rootfs/ /
