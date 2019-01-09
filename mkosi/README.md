# LilyDev -- mkosi

## Full virtual machine

Runs on: any OS with a Virtual Machine software.

Download the latest [release](https://github.com/fedelibre/LilyDevOS/releases).
The image built for being emulated on VM software has a `-vm` suffix.

You must first decompress the zip archive.  Then you can verify the integrity
of the data running this command in the directory where you've extracted the
files:

    sha256sum -c SHA256SUMS

The image is a *raw* disk image format, which can be converted to the specific
format used by the software you want to use.

### VirtualBox

If you are running Windows or Mac in the host, you'll want to use VirtualBox,
which requires VDI images.  You can generate it with this command:

    VBoxManage convertfromraw lilydev-debian-vm-VERSION.img lilydev-debian-vm-VERSION.vdi

Please follow all the steps described in the LilyPond Contributor guide to
[install and configure the VirtualBox machine](http://lilypond.org/doc/v2.19/Documentation/contributor/lilydev#installing-lilydev-in-virtualbox).
In particular, remember that you need to enable EFI or the image won't boot.

### QEMU/libvirt

If your host is running Linux, you can use QEMU.  It works well with either
the raw image or its own format (qcow2), which you can generate it with:

    qemu-img convert -f raw -O qcow2 lilydev-debian-vm-VERSION.img lilydev-debian-vm-VERSION.qcow2

Raw images give optimal performance, but only basic features are available
(for example, no snapshots). qcow2 is the QEMU image format and has a number of
features including snapshots.  In the rest of this section we'll assume you
converted it to qcow2.

Move the image to the usual location for libvirt images:

    mv lilydev-debian-vm-VERSION.qcow2 ~/.local/share/libvirt/images/

Now you can *register* the virtual machine in libvirt or, in libvirt terms,
*define a domain*:

    virt-install --name LilyDev-debian-vm-VERSION --memory 1024 --os-type=linux --os-variant=debian9 --boot loader=/usr/share/edk2/ovmf/OVMF_CODE.fd --network=default --disk ~/.local/share/libvirt/images/lilydev-debian-vm-VERSION.qcow2 --noautoconsole --import

(available OS variants are listed by the command `osinfo-query os`)

512M of RAM *should* be enough, as the image contains also a swap partition
of 2G.  If you can assign 1024M, even better.
In case you see some weird error while compiling lilypond, your guest might be
running out of memory (check the RAM available with the command `free -m`)
and you should try assigning more RAM to the virtual machine.

Now the virtual machine will be available on all libvirt clients, such as
[virt-manager](https://virt-manager.org/) or
[GNOME Boxes](https://wiki.gnome.org/Apps/Boxes).
If you still want to launch it from command-line, use these commands:

    virsh start LilyDev-debian-vm-VERSION
    virt-viewer --connect qemu:///session LilyDev-debian-vm-VERSION

You'll log in as `dev` user (the password is `lilypond`).

Desktop preferences suggestions:

- Change keybord layout from default US (american) to your national layout in
*Applications»Settings»Keyboard»Layout*: add your layout and then move it up
to the list so it will be the default.


## Container

Runs on: Linux only.
Requirements: systemd-nspawn, available in `systemd-container` package.

It's the best choice if you want to run LilyDev in a Linux host: lightweight,
full access to host system resource (including RAM), easy access from host
to guest file system through the file manager (so no need to set up shared
folders).

Download the latest [release](https://github.com/fedelibre/LilyDevOS/releases).
You can choose your favorite Linux distribution: current options are Debian
and Fedora, but others may be added.

You need root privileges to extract the content, so you'd better do it on
the command line:

    sudo tar xf lilydev-DISTRO-VERSION.tar.xz

Start the container:

    sudo systemd-nspawn -bD lilydev-DISTRO-VERSION

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
In case the id is different, read
[this tutorial on changing UID and GID](https://muffinresearch.co.uk/linux-changing-uids-and-gids-for-user/).

### Running graphical applications from the container

You might need to run one or more graphical applications from the container,
for example gitk or lily-git.  This should work out of the box, if two
requirements are met:

1. The id of the guest user must the same as the id of the host user. Usually
   it is the same; if it's not, see above link.
2. Another requirement is that the DISPLAY variable must be set to the same
   value of the DISPLAY value in the host. We assumed that the value is `:0`.
   If it's not, run `echo $DISPLAY` in the host and change accordingly the
   DISPLAY variable in `~/.bashrc` in the guest.

The containers does not include a browser, which is needed to log in to Rietveld
while uploading the patch via `git-cl`.  Unfortunately I could not find any text
browser which worked with `git-cl`.  As installing a graphical browser would
add several dependencies and I want to keep the containers as small as possible,
the best solution is launching `git-cl` from the host.  Otherwise you may
install a browser in the container, e.g.:

    sudo dnf install firefox           # Fedora
    sudo aptitude install firefox-esr  # Debian
