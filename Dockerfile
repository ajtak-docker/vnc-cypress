FROM dorowu/ubuntu-desktop-lxde-vnc:focal-lxqt
Maintainer Jakub Fridrich <https://fb.me/xfridrich>

RUN apt -y update && apt -y upgrade

RUN apt -y install libgtk2.0-0 libgtk-3-0 libnss3 libxss1 libasound2 libxtst6 xauth xvfb nodejs npm

RUN mkdir -p /cypress

RUN cd /cypress && npm install cypress --save-dev

CMD ["/bin/sh"]

ENTRYPOINT ["/bin/sh", "-c"]
