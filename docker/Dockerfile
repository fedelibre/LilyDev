FROM ubuntu:18.04

# Allow taking Guile 1.8 (and prerequisites) from Ubuntu 16.04.
COPY xenial.list /etc/apt/sources.list.d/xenial.list

## DEBIAN_FRONTEND=noninteractive prevents tzdata (etc.?) from
## prompting after these packages are added.
##
## TODO: Find out how to use the host's local time zone instead of UTC
## in the container.
##
## --no-install-recommends avoids installing recommended but not
## required packages, e.g. xterm.
##
## YUCK: Testing, e.g. make test-baseline, uses git.
##
COPY ./urw35fonts.sh /root

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
    fonts-texgyre \
    g++-8 \
    gettext \
    ghostscript \
    git \
    groff \
    gsfonts \
    gsfonts-x11 \
    guile-1.8-dev \
    help2man \
    imagemagick \
    libfl-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libgmp3-dev \
    libltdl-dev \
    libpango1.0-dev \
    lmodern \
    m4 \
    mftrace \
    netpbm \
    pkg-config \
    python-all-dev \
    quilt \
    rsync \
    texi2html \
    texinfo \
    texlive-fonts-recommended \
    texlive-generic-recommended \
    texlive-lang-cyrillic \
    texlive-latex-base \
    texlive-latex-recommended \
    texlive-metapost \
    texlive-xetex \
    wget \
    zip \
&& update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8 \
&& rm -rf /var/lib/apt/lists/* \
&& bash /root/urw35fonts.sh
