###########################################################################
# lilypond-base: minimal image for running lilypond and its scripts
###########################################################################
FROM ubuntu:22.04 as lilypond-base

## The fonts-texgyre package (the preferred default fonts) is not
## strictly required, since LilyPond can fall back on other fonts, but
## it is convenient to include in the base image so that it is
## consistently available in derived images.
##
RUN apt-get update \
&& DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends install -y \
    fonts-texgyre \
    ghostscript \
    guile-2.2 \
    libpangoft2-1.0-0 \
    python-is-python3 \
    python3 \
    sudo \
&& rm -rf /var/lib/apt/lists/*

# Add a non-root user who can run sudo without a password.
RUN useradd -m -s /bin/bash user \
&& adduser user sudo \
&& echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
&& sudo -u user touch ~user/.sudo_as_admin_successful

USER user
COPY --chown=user:user ./install/base_bashrc_addendum /home/user/base_bashrc_addendum
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
    astyle \
    autoconf \
    autotools-dev \
    bison \
    dblatex \
    debhelper \
    extractpdfmark \
    flex \
    fontforge \
    fonts-dejavu \
    fonts-linuxlibertine \
    fonts-noto-cjk \
    fonts-urw-base35 \
    g++-12 \
    gcc-12 \
    gdb \
    gettext \
    git \
    groff \
    guile-2.2-dev \
    help2man \
    imagemagick \
    less \
    libfl-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libgmp3-dev \
    libgs-dev \
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
    texlive-font-utils \
    texlive-lang-cyrillic \
    texlive-latex-base \
    texlive-latex-recommended \
    texlive-metapost \
    texlive-plain-generic \
    texlive-xetex \
    tidy \
    ttf-bitstream-vera \
    zip \
&& update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 1200 \
                       --slave /usr/bin/g++ g++ /usr/bin/g++-12 \
&& rm -rf /var/lib/apt/lists/*

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
&& echo "   guest ok = yes" >> /etc/samba/smb.conf \
&& echo "   force user = user" >> /etc/samba/smb.conf

USER user
