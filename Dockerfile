FROM alpine:3.7
MAINTAINER Janne K <0x022b@gmail.com>

HEALTHCHECK CMD nc -zw5 google.com 443 || exit 1
ENTRYPOINT ["docker-entrypoint"]
CMD ["container-daemon"]

ARG VOLUME=/data

RUN \
apk upgrade --no-cache && \
apk add --no-cache \
	ca-certificates \
	iptables \
	ip6tables \
	py2-pip \
	su-exec && \
pip install --no-cache-dir --upgrade pip \
	'flexget<2.11' \
	'transmissionrpc==0.11' && \
mkdir -m 0777 -p "${VOLUME}"

VOLUME ["${VOLUME}"]
WORKDIR "${VOLUME}"

COPY rootfs/ /
