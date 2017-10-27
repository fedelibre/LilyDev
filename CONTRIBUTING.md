# Contributing to LilyDev

The images are built using [mkosi](https://github.com/systemd/mkosi/).
mkosi required version is 3 or later.

If your distro has an older version, you should install it from source.
Dependencies are listed on mkosi README.
Then download the repository and run the installation:

    git clone git@github.com:systemd/mkosi.git
    cd mkosi
    sudo python3 setup.py install

Usage is printed with this command:

    mkosi --help

The commands used to build the images are in the Makefile.
