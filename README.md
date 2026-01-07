# docker-firefox-java-vnc

Docker image that runs an old Firefox web browser with an outdated Java plugin (1.6) and offers access to it through VNC. It can be used to support old Java code, typically found in legacy web management interfaces.

This image is built on Debian Wheezy, therefore the available browser is Iceweasel, the Debian-rebranded version of Firefox. The Java support is based on OpenJDK 6 and the IcedTea plugin.

## How to use this image

This will start a container:

    $ docker run -d --rm -p 5900:5900 --name firefox-java-vnc mablanco/firefox-java-vnc

Now you can access Firefox with any VNC client opening localhost on standard port 5900.

### Setting the Geometry

By default the `-geometry` option is set to `1024x768`, if you want to override that you can add that as a command after container name:

    $ docker run -d --rm -p 5900:5900 --name firefox-java-vnc mablanco/firefox-java-vnc -geometry 960x640

> NOTE: According the the [documentation](https://github.com/LibVNC/x11vnc/blob/master/doc/OPTIONS.md) `-geometry` and `-scale` are the same option "-geometry WxH: Same as -scale WxH"

## Troubleshooting

If the container starts and then dies without notice, follow these steps to try to debug the problem:

1. Launch the container without the `--rm` argument: `docker run -p 5900:5900 --name firefox-java-vnc mablanco/firefox-java-vnc`
2. When the container exists, run the command `docker ps -a | grep firefox-java-vnc` and check if the exit code is 139
3. Have a look at your kernel logs with `sudo dmesg` and look for a line like this one: `x11vnc[154000] vsyscall attempted with vsyscall=none...`

If you get the same results from steps 2 and 3, then you're suffering from the same issue described in the following links:
- https://einsteinathome.org/es/content/vsyscall-now-disabled-latest-linux-distros
- https://github.com/moby/moby/issues/28705

You can solve this issue by adding the parameter `vsyscall=emulate` to the Grub command line. You can do that in Debian by editing `/etc/default/grub` and adding that parameter to the `GRUB_CMDLINE_LINUX_DEFAULT` variable, running `sudo update-grub` afterwards and finally rebooting your computer.

Remember that this is not a **bug** but just an **issue** derived from the fact that `vsyscall` is defaulted to `none` in modern Linux distros for security reasons, so use this workaround carefully.
