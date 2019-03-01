FROM alpine:3.9
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
    py3-pip \
    su-exec && \
pip3 install --no-cache-dir --upgrade pip \
    'flexget<2.20' \
    'transmissionrpc' && \
ln -s /etc/TZ /etc/timezone

COPY rootfs/ /
