# LilyDevOS

This repository is meant to be an alternative to
[LilyDev](https://github.com/fedelibre/LilyDev).

It provides two different options: a lightweight container for Linux hosts
only and a full VM image for all operating systems.


## How to use the images

### Full virtual machine

Runs on: any OS with a Virtual Machine software.

Download the latest [release](https://github.com/fedelibre/LilyDevOS/releases).
The image built for being emulated on VM software has a `-vm` suffix.

You must first decompress the zip archive.  Then you can verify the integrity
of the data comparing the hash in the SHA256SUMS file with the output of
this command (in Linux):

    sha256sum lilydevos-vm-VERSION.raw

In Linux there are several VM GUI managers, like Virt Manager or Gnome Boxes.
But you can also use the command line.  Something like this should work (tested
on Fedora):

    qemu-kvm -m 512 -smp 2 -bios /usr/share/edk2/ovmf/OVMF_CODE.fd -drive format=raw,file=lilydevos-vm-VERSION.raw

512M of RAM *should* be enough, as the image contains also a swap partition
of 2G.  If you can assign 1024M, even better.
In case you see some weird error while compiling lilypond, your guest might be
running out of memory (check the RAM available with the command `free -m`)
and you should try assigning more RAM to the virtual machine.

You'll log in as `dev` user (the password is `lilypond`).

Desktop preferences suggestions:

- Disable the screensaver: click on the menu icon on the bottom left, then
on *Preferences»Monitor settings*; in the Mode dropdown menu choose
*Disable Screen Saver*.

- Change keybord layout from default US (american) to your national layout in
*Preferences»Keyboard and Mouse»Keyboard Layout*; add your layout and
then move it up to the list so it will be the default.


### Container

Runs on: Linux only.
Requirements: systemd.

It's the best choice if you want to run LilyDevOS in a Linux host: lightweight,
full access to host system resource (including RAM), easy access from host
to guest file system through the file manager (so no need to set up shared
folders).

Download the latest [release](https://github.com/fedelibre/LilyDevOS/releases).
You need root privileges to extract the content, so you'd better do it on
the command line:

    sudo tar xf lilydevos-VERSION.tar.xz

Start the container:

    sudo systemd-nspawn -bD lilydevos-VERSION

At the login type `root` and press Enter (no password needed).  Then change to
the regular user `dev`, go to the home directory and run the setup.sh script:

    su dev
    cd
    ./setup.sh

You are now ready to start contributing to LilyPond.

Remember that `dev` user can get root privileges with `sudo` (even if you
should not need it). The password is `lilypond`.

There's a good chance that your user in the Linux host and the `dev` user
in the container have the same uid (probably 1000, use the command `id`
to find it out).  If that's the case, you can easily access and edit the files
in the container from your host as you wish, using a file manager or your
favorite GUI text editor.


## How to contribute to this repository

[mkosi](https://github.com/systemd/mkosi/) required version is 3 or later.
If your distro has an older version, you should install it from source.
Dependencies are listed on mkosi README.

Then download the repository and run the installation:

    git clone git@github.com:systemd/mkosi.git
    cd mkosi
    sudo python3 setup.py install

Usage is printed with this command:

    mkosi --help

The commands used to build the images are in the Makefile.

