FROM debian:8.6


ENV NODE_DOWNLOAD_URL=https://nodejs.org/dist/v6.9.4/node-v6.9.4-linux-x64.tar.xz

RUN     apt-get update && apt-get install -y --force-yes curl xz-utils && rm -rf /var/lib/apt/lists/* && find /usr/share/doc -depth -type f ! -name copyright|xargs rm || true && find /usr/share/doc -empty|xargs rmdir || true && rm -rf /usr/share/man/* /usr/share/groff/* /usr/share/info/* && rm -rf /usr/share/lintian/* /usr/share/linda/* /var/cache/man/*

RUN     cd  /opt && \
        curl -SL "$NODE_DOWNLOAD_URL" -o node.tar.xz && \
        xz -d node.tar.xz && \
        tar -xf node.tar && \
        rm -f node.tar && \
        ln -s * node && \
        ln -s /opt/node/bin/node /usr/local/bin && \
        ln -s /opt/node/bin/npm /usr/local/bin

EXPOSE 8080

COPY startDevserver.sh /startDevserver.sh

VOLUME ["/opt/myproject"]

ENTRYPOINT ["/startDevserver.sh"]






