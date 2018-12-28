FROM alpine:3.8
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
    py2-pip \
    su-exec && \
pip install --no-cache-dir --upgrade pip \
    'flexget<2.18' \
    'transmissionrpc==0.11' && \
ln -s /etc/TZ /etc/timezone

COPY rootfs/ /
