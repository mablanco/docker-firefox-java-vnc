FROM debian:wheezy-slim
RUN	mkdir -p /usr/share/man/man1 && \
    echo "deb http://archive.debian.org/debian wheezy main contrib non-free" > /etc/apt/sources.list && \
    apt-get update && \
    apt-get -y --force-yes install tzdata=2016d-0+deb7u1 && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install x11vnc xvfb jwm iceweasel openjdk-6-jre tzdata-java icedtea-6-plugin icedtea-netx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN	mkdir ~/.vnc && \
    echo "exec jwm &" >> ~/.xinitrc && \
    echo "firefox" >> ~/.xinitrc && \
    chmod 755 ~/.xinitrc
ENTRYPOINT ["/usr/bin/x11vnc", "-forever", "-create"]
