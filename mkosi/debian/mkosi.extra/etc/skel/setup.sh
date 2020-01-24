#!/bin/bash

###  GIT CONFIGURATION  ###
if [ ! -f ~/.gitconfig ];
then
  echo "This wizard will help you to setup your Git configuration."
  echo -n "Please enter your name and surname: "
  read NAME
  git config --global user.name "$NAME"
  echo -n "Please enter your email address: "
  read EMAIL
  git config --global user.email "$EMAIL"
  echo "Your commit messages will be signed as '$NAME <$EMAIL>'."
else
  echo "Git is already configured. Skipping..."
  echo "Remove ~/.gitconfig to force a new configuration."
fi


###  DOWNLOAD REPOSITORIES  ###
if [ ! -d ~/git-cl -a ~/lilypond-git -a ~/lilypond-extra -a ~/gub -a ~/LilyDev ];
then
  echo "Now we'll download the repositories needed to contribute to LilyPond development. Proceed only if you have a working Internet connection."
  read -p "Press Enter to continue. "
  cd $HOME
  echo "Cloning in your home directory: `pwd`. It will take a few minutes."
  echo "Downloading git-cl repository..."
  git clone git://github.com/gperciva/git-cl.git
  echo "Downloading lilypond-extra repository..."
  git clone git://github.com/gperciva/lilypond-extra/
  echo "Downloading lilypond-git repository..."
  git clone git://git.sv.gnu.org/lilypond.git lilypond-git
  echo "Downloading gub repository..."
  git clone git://github.com/gperciva/gub.git gub
  echo "Downloading LilyDev repository..."
  git clone git://github.com/fedelibre/LilyDev.git
else
  echo "Repositories already downloaded. Skipping..."
  echo
fi


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

# Download each font file
if [ ! -d ~/.local/share/fonts ];
then
  echo "Download Greek and Cyrillic fonts from Ghostscript URW35..."
  for font in $URW35FONTS
  do
    # The URL GET parameter f=$font will be replaced with the font file name
    WGETURL="http://git.ghostscript.com/?p=urw-core35-fonts.git;a=blob;hb=79bcdfb34fbce12b592cce389fa7a19da6b5b018;f=$font;"
    # wget options: less verbose, create directory, don't make host directory,
    # use file name from HTTP header, set download location
    wget -nv -x -nH --content-disposition -P ~/.local/share/fonts "$WGETURL"
  done
else
  echo "Fonts already downloaded. Skipping..."
  echo
fi


###  EXIT  ###
echo "Configuration completed successfully!"
exit 0
