# docker-firefox-java-vnc

Docker image that runs an old Firefox web browser with an outdated Java plugin (1.6) and offers access to it through VNC. It can be used to support old Java code, typically found in legacy web management interfaces.

This image is built on Debian Wheezy, therefore the available browser is Iceweasel, the Debian-rebranded version of Firefox. The Java support is based on OpenJDK 6 and the IcedTea plugin.

## How to use this image

This will start a container:

    $ docker run -d --net host --name firefox-java-vnc mablanco/firefox-java-vnc

Now you can access Firefox with any VNC client on standard port 5900.
