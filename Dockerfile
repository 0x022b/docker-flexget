FROM alpine:3.8
LABEL maintainer="Janne K <0x022b@gmail.com>"

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
	'flexget<2.13' \
	'transmissionrpc==0.11' && \
ln -s /etc/TZ /etc/timezone && \
mkdir -m 0777 -p "${VOLUME}"

VOLUME ["${VOLUME}"]
WORKDIR "${VOLUME}"

COPY rootfs/ /
