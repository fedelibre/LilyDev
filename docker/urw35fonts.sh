###  DOWNLOAD OTF URW FONTS  ###
# LilyPond docs need Greek and Cyrillic fonts from Ghostscript URW35.
# However the Debian package fonts-urw-base35 (currently in testing/buster)
# does not include OpenType font files. So we have to download these files
# from ghostscript repository.
URW35FONTS=\
"C059-BdIta.otf
C059-Bold.otf
C059-Italic.otf
C059-Roman.otf
NimbusMonoPS-Bold.otf
NimbusMonoPS-BoldItalic.otf
NimbusMonoPS-Italic.otf
NimbusMonoPS-Regular.otf
NimbusSans-Bold.otf
NimbusSans-BoldOblique.otf
NimbusSans-Oblique.otf
NimbusSans-Regular.otf"

export DEBIAN_FRONTEND=noninteractive

# install packages required to obtain the fonts
install_packages () {
  apt-get update
  apt-get --no-install-recommends install -y wget
}

# clean up to avoid bloating the image with packages not necessary for
# LilyPond development
clean_packages () {
  apt-get remove -y wget
  apt-get autoremove
  rm -rf /var/lib/apt/lists/*
}

# Download each font file
if [ ! -d ~/.local/share/fonts ];
then
  install_packages
  for font in $URW35FONTS
  do
    # The URL GET parameter f=$font will be replaced with the font file name
    WGETURL="http://git.ghostscript.com/?p=urw-core35-fonts.git;a=blob;hb=79bcdfb34fbce12b592cce389fa7a19da6b5b018;f=$font;"
    # wget options: less verbose, create directory, don't make host directory,
    # use file name from HTTP header, set download location
    wget -nv -x -nH --content-disposition -P ~/.local/share/fonts "$WGETURL"
  done
  clean_packages
else
  echo "Fonts already downloaded. Skipping..."
  echo
fi
