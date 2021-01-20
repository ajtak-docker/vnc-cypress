FROM dorowu/ubuntu-desktop-lxde-vnc:focal-lxqt as system

RUN apt-get -y update && apt-get -y upgrade

RUN apt-get -y install libgtk2.0-0 libgtk-3-0 libnss3 libxss1 libasound2 libxtst6 xauth xvfb

RUN mkdir -p /cypress

RUN cd /cypress && yarn add cypress --dev

################################################################################
# merge with dorowu/ubuntu-desktop-lxde-vnc:focal-lxqt
################################################################################
FROM system
LABEL Maintainer Jakub Fridrich <https://fb.me/xfridrich>

COPY --from=builder /src/web/dist/ /usr/local/lib/web/frontend/
COPY rootfs /
RUN ln -sf /usr/local/lib/web/frontend/static/websockify /usr/local/lib/web/frontend/static/novnc/utils/websockify && \
	chmod +x /usr/local/lib/web/frontend/static/websockify/run

EXPOSE 80
WORKDIR /root
ENV HOME=/root \
    SHELL=/bin/bash
HEALTHCHECK --interval=30s --timeout=5s CMD curl --fail http://127.0.0.1:6079/api/health
ENTRYPOINT ["/startup.sh"]
