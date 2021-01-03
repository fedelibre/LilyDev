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
if [ ! -d ~/gub -a ~/lilypond-extra -a ~/lilypond-git ]; then
  echo "Now we'll download the repositories needed to contribute to LilyPond development. Proceed only if you have a working Internet connection."
  read -p "Press Enter to continue. "
fi

if [ ! -d ~/gub ]; then
  echo "Downloading gub repository..."
  git clone git://github.com/gperciva/gub.git gub
fi
if [ ! -d ~/lilypond-extra ]; then
  echo "Downloading lilypond-extra repository..."
  git clone git://github.com/gperciva/lilypond-extra/ ~/lilypond-extra
fi
if [ ! -d ~/lilypond-git ]; then
  echo "Downloading lilypond-git repository..."
  git clone https://gitlab.com/lilypond/lilypond.git lilypond-git
fi


###  EXIT  ###
echo "Configuration completed successfully!"
exit 0
