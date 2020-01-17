###########################################################################
# lilypond-base: minimal image for running lilypond and its scripts
###########################################################################
FROM ubuntu:19.10 as lilypond-base

# Allow taking Guile 1.8 (and prerequisites) from Ubuntu 16.04.
COPY ./install/xenial.list /etc/apt/sources.list.d/xenial.list

## DEBIAN_FRONTEND=noninteractive prevents apt-get from prompting
## after certain packages are added.
##
## --no-install-recommends avoids installing recommended but not
## required packages, e.g. xterm.
##
## The fonts-texgyre package (the preferred default fonts) is not
## strictly required, since LilyPond can fall back on other fonts, but
## it is convenient to include in the base image so that it is
## consistently available in derived images.
##
RUN apt-get update \
&& DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends install -y \
    fonts-texgyre \
    ghostscript \
    guile-1.8 \
    libpangoft2-1.0-0 \
    python-all \
    sudo \
&& rm -rf /var/lib/apt/lists/*

# Add a non-root user who can run sudo without a password.
RUN useradd -m -s /bin/bash user \
&& adduser user sudo \
&& echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
&& sudo -u user touch ~user/.sudo_as_admin_successful

USER user
COPY ./install/base_bashrc_addendum /home/user/base_bashrc_addendum
RUN cat ~/base_bashrc_addendum >> ~/.bashrc && rm ~/base_bashrc_addendum \
&& mkdir ~/lilypond-build

###########################################################################
# lilypond: for running LilyPond
###########################################################################
FROM lilypond-base as lilypond

# Include LilyPond in the PATH.  We don't do this in the base image
# because we don't want the development workflow to come to depend on
# it accidentally.
RUN echo 'PATH="$HOME/lilypond-build/out/bin:$PATH"' >> ~/.profile

## LilyPond itself requires nothing more, but you may wish to install
## extra packages that your personal workflow requires.  Adding them
## here will add them to the lilypond image without adding them to the
## lilypond-dev image.  Example:

# USER root
# RUN apt-get update \
# && DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends install -y \
#     make \
# && rm -rf /var/lib/apt/lists/*
# USER user

###########################################################################
# lilypond-dev: for LilyPond development
###########################################################################
FROM lilypond-base as lilypond-dev

## YUCK: Testing, e.g. make test-baseline, uses git.
##
## Packages that are for debugging and profiling rather than building
## and testing:
##
##   * gdb
##   * less
##   * moreutils (ts, errno, etc.)
##   * strace
##
USER root
RUN apt-get update \
&& DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends install -y \
    autoconf \
    autotools-dev \
    bison \
    dblatex \
    debhelper \
    extractpdfmark \
    flex \
    fontforge \
    fonts-dejavu \
    fonts-freefont-ttf \
    fonts-ipafont-gothic \
    fonts-ipafont-mincho \
    g++ \
    gdb \
    gettext \
    git \
    groff \
    gsfonts \
    gsfonts-x11 \
    guile-1.8-dev \
    help2man \
    imagemagick \
    less \
    libfl-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libgmp3-dev \
    libltdl-dev \
    libpango1.0-dev \
    lmodern \
    m4 \
    make \
    mftrace \
    moreutils \
    netpbm \
    pkg-config \
    quilt \
    rsync \
    strace \
    texi2html \
    texinfo \
    texlive-fonts-recommended \
    texlive-generic-recommended \
    texlive-lang-cyrillic \
    texlive-latex-base \
    texlive-latex-recommended \
    texlive-metapost \
    texlive-xetex \
    tidy \
    zip \
&& rm -rf /var/lib/apt/lists/*

USER user
COPY ./install/urw35fonts.sh /home/user
RUN bash ~/urw35fonts.sh && rm ~/urw35fonts.sh

# Support sharing the build directory with Samba.  If you don't need
# this, you can reduce the image size slightly by commenting it out.
# You'll also need to modify docker-compose.yaml so that it does not
# try to start smbd.
USER root
RUN apt-get update \
&& DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends install -y \
    samba \
&& rm -rf /var/lib/apt/lists/* \
&& echo "[lilypond-build]" >> /etc/samba/smb.conf \
&& echo "   path = /home/user/lilypond-build" >> /etc/samba/smb.conf \
&& echo "   read only = yes" >> /etc/samba/smb.conf \
&& echo "   guest ok = yes" >> /etc/samba/smb.conf

USER user
