# LilyDevOS

This repository, named LilyDevOS, is the replacement of
[LilyDev](https://github.com/fedelibre/LilyDev).
Even if the final product will still be called LilyDev, this
is the place where the images will be created from now on.

## mkosi or Docker images?

Two different tools are used to generate the LilyDev images.

**mkosi** builds a full virtual machine which can run on any OS via
VirtualBox, libvirt or any other virtualization software. It builds
also lightweight containers, which currently run only on Linux
using `systemd-nspawn` (installed by default in modern distros).

**Docker** was introduced later to make the lightweight LilyDev container
available also to Windows and Mac users (but it works on Linux too!).

Containers are recommended as they are lightweight and easy to use.
Choose the image which best suits you, download the
[latest release](releases/latest/) and follow the instuctions in
each tool README:

* [mkosi](mkosi/): recommended for Linux hosts.
* [docker](docker/): recommended for Windows or Mac hosts.
