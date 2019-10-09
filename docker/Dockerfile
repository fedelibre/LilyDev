###########################################################################
# lilypond-base: minimal image for running lilypond and its scripts
###########################################################################
FROM ubuntu:18.04 as lilypond-base

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
RUN apt-get update \
&& DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends install -y \
    ghostscript \
    guile-1.8 \
    libpangoft2-1.0-0 \
    python-all \
&& rm -rf /var/lib/apt/lists/*

# The default one-line prompt gets long.  Set a two-line prompt.
#
# \e]2;...\a    set the window title in xterm
# \e[1;7m       bold, reverse
# \e[0m         normal
#
RUN echo 'PS1="\\[\\e]2;\\h\\a\\]\\[\\e[1;7m\\] \\h:\\w \\[\\e[0m\\]\\n\\\\$ "' >> ~/.bashrc

###########################################################################
# lilypond: for running LilyPond
###########################################################################
FROM lilypond-base as lilypond

## LilyPond itself requires nothing more, but you may wish to install
## extra packages that your personal workflow requires.  Adding them
## here will add them to the lilypond image without adding them to the
## lilypond-build image.  Example:

# RUN apt-get update \
# && DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends install -y \
#     make \
# && rm -rf /var/lib/apt/lists/*

###########################################################################
# lilypond-build: for LilyPond development
###########################################################################
FROM lilypond-base as lilypond-build

COPY ./urw35fonts.sh /root

## YUCK: Testing, e.g. make test-baseline, uses git.
##
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
    make \
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
    zip \
&& update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8 \
&& bash /root/urw35fonts.sh && rm /root/urw35fonts.sh \
&& rm -rf /var/lib/apt/lists/*
