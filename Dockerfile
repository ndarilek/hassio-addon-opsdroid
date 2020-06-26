ARG BUILD_FROM=homeassistant/amd64-base:latest
FROM $BUILD_FROM

ENV LANG C.UTF-8

WORKDIR /
RUN apk add --no-cache py3-pip py3-wheel python3-dev musl-dev gcc git && \
    pip3 install opsdroid==0.19.0 opsdroid-homeassistant==0.1.7
COPY start.sh /app/start.sh
ENTRYPOINT ["/app/start.sh"]

LABEL io.hass.version="VERSION" io.hass.type="addon" io.hass.arch="armhf|aarch64|i386|amd64"
