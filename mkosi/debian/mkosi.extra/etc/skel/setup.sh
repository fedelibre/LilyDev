#!/bin/bash
printf "This wizard will help you to setup your Git configuration.\n\n"

if [ -f ~/.gitconfig ]; then
  printf "A file configuration already exists. If you proceed, it will be overwritten.\nPress Ctrl+C to cancel/Press enter to proceed: "
  read _
fi

echo -n "Please enter your name and surname: "
read NAME
git config --global user.name "$NAME"
echo -n "Please enter your email address: "
read EMAIL
git config --global user.email "$EMAIL"
echo "Your commit messages will be signed as '$NAME <$EMAIL>'."

git config --global color.ui auto
echo

# If this script is run again after first configuration,
# print a warning and offer the option to exit.
if [ -d ~/git-cl -a ~/lilypond-git -a ~/lilypond-extra ]; then
  printf "You've already downloaded the repositories. Press Ctrl+C close the wizard: "
read _
fi

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

echo "Configuration completed successfully!"
read -p "Press enter to close the wizard."
