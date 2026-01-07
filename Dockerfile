FROM debian:wheezy-20190228-slim
ARG DEBIAN_FRONTEND=noninteractive
RUN mkdir -p /usr/share/man/man1 && \
    echo "deb http://archive.debian.org/debian wheezy main contrib non-free" > /etc/apt/sources.list && \
    apt-get update && \
    apt-get --assume-yes --force-yes --show-upgraded dist-upgrade && \
    apt-get --assume-yes --force-yes install tzdata=2016d-0+deb7u1 && \
    apt-get --assume-yes --force-yes install x11vnc xvfb jwm iceweasel openjdk-6-jre tzdata-java icedtea-6-plugin icedtea-netx && \
    update-alternatives --set javaws /usr/lib/jvm/java-6-openjdk-amd64/jre/bin/javaws && \
    apt-get --assume-yes --force-yes autoremove && \
    apt-get clean && \
    rm -rf /var/lib/{apt,dpkg,cache,log} && \
    mkdir ~/.vnc && \
    echo "exec jwm &" >> ~/.xinitrc && \
    echo "firefox" >> ~/.xinitrc && \
    chmod 755 ~/.xinitrc
ENTRYPOINT ["/usr/bin/x11vnc", "-nopw", "-forever", "-create"]
CMD ["-geometry", "1024x768"]
