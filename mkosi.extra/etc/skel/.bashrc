# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
#export SYSTEMD_PAGER=less

# User specific aliases and functions

# Git prompt preferences
# https://fedoraproject.org/wiki/Git_quick_reference#Display_current_branch_in_bash
source /usr/share/git-core/contrib/completion/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export PS1='[\u@\h:\W$(declare -F __git_ps1 &>/dev/null && __git_ps1 " (%s)")]\$ '

# Default terminal editor
export EDITOR=/bin/nano

# Variables needed to build LilyPond
export LILYPOND_GIT=~/lilypond-git
export LILYPOND_BUILD_DIR=~/lilypond-git/build
export LILYPOND_WEB_MEDIA_GIT=~/lilypond-extra

# Add other directories to the PATH
export PATH=$HOME/git-cl:$PATH

