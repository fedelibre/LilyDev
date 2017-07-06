# LilyDevOS

This repository is meant to *become* an alternative to
[LilyDev](https://github.com/fedelibre/LilyDev).

Currently it provides just a container which can be run only on Linux hosts.
Next step will be building images which include a desktop environment and
can be loaded on virtual machine software on Mac and Windows.


## How to use the images released

Requirements: Linux host, systemd-nspawn.

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
should not need it).

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

The command used to build LilyDevOS is in the Makefile.

