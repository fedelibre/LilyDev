# LilyDev

LilyDev is a custom GNU/Linux operating system which includes
all the necessary software and tools to compile
[LilyPond](http://lilypond.org/).

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
[latest release](https://github.com/fedelibre/LilyDev/releases/latest)
and follow the instuctions in each tool README:

* [mkosi](mkosi/): recommended for Linux hosts (container)
or Windows hosts (VM image that runs, e.g., on VirtualBox)
* [docker](docker/): recommended for Windows or Mac hosts.
