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

In Linux you can test it quickly by using something like this (tested on
Fedora.. the location of `OVMF_CODE.fd` might be different in other distros):

    qemu-kvm -m 512 -smp 2 -bios /usr/share/edk2/ovmf/OVMF_CODE.fd -drive format=raw,file=lilydevos-vm-VERSION.raw

512M of RAM *should* be enough, as the image contains also a swap partition
of 2G.  If you can assign 1024M, even better.
In case you see some weird error while compiling lilypond, your guest might be
running out of memory (check the RAM available with the command `free -m`)
and you should try assigning more RAM to the virtual machine.

Once you are sure about the suitable settings, you'd better *register* the
virtual machine in libvirt or, in libvirt terms, *define a domain*.  Enter
the directory where you saved the .raw file and launch this command:

    virt-install --name lilydevos-vm-VERSION --memory 1024 --os-type=linux \
    --os-variant=fedora25 --boot loader=/usr/share/edk2/ovmf/OVMF_CODE.fd \
    --network=default --disk /FULL/PATH/TO/lilydevos-vm-VERSION.raw \
    --noautoconsole --import

(available OS variants are listed by the command `osinfo-query os`)

Now the virtual machine will be available on all libvirt clients, such as
[virt-manager](https://virt-manager.org/) or
[GNOME Boxes](https://wiki.gnome.org/Apps/Boxes).
If you still want to launch it from command-line, use these commands:

    virsh start lilydevos-vm-VERSION
    virt-viewer --connect qemu:///session lilydevos-vm-VERSION

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
Requirements: systemd-nspawn, available in `systemd-container` package.

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
    ./setup.sh    # this should be run only the first time

You are now ready to start contributing to LilyPond.

When you've done, you can shutdown the machine with these commands:

    $ exit
    # shutdown -h now

(the first command will let you go back from dev user to root user,
who has the privileges to shutdown the system)

Remember that `dev` user can get root privileges with `sudo` (even if you
should not need it). The password is `lilypond`.

There's a good chance that your user in the Linux host and the `dev` user
in the container have the same uid (probably 1000, use the command `id`
to find it out).  If that's the case, you can easily access and edit the files
in the container from your host as you wish, using a file manager or your
favorite GUI text editor.
In case the id is different, read [this tutorial on changing UID and GID]
(https://muffinresearch.co.uk/linux-changing-uids-and-gids-for-user/).

Finally, you might need to run a graphical application from the container,
for example gitk.  This is not allowed, unless you specify the display
you want to use.  Check it out in the host with this command:

    echo $DISPLAY

If the output is `:0`, then test it in the container with:

    DISPLAY=:0 gitk

and add it as alias so you can type just `gitk`:

    echo 'alias gitk="DISPLAY=:0 gitk"' >> /home/dev/.bashrc

The container does not include a browser, which is needed to log in to Rietveld
while uploading the patch via `git-cl`.  Unfortunately I could not find any text
browser which worked with `git-cl`.  As installing a graphical browser would
add several dependencies and I want to keep the container as small as possible,
the best solution is launching `git-cl` from the host.  Otherwise you may
install a browser in the container and add an alias similar to the above, e.g.:

    sudo dnf install firefox
    echo 'alias firefox="DISPLAY=:0 firefox"' >> /home/dev/.bashrc


## Guile 2

The images contain only `guile-1.8`, the version needed for the regular
contributor.  Who wants to work on migration to guile-2 should install
this package:

    sudo dnf install guile-devel


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

