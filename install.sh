#!/bin/bash

which git > /dev/null 2>&1
if  [[ $? != 0 ]]
then
    echo 'You must install git before using my emacs setup.'
    exit 1
fi

if [[ ! -d ~/.emacs.d ]]
then
    git clone https://github.com/Ronmi/emacs ~/.emacs.d
else
    G="git --git-dir=$HOME/.emacs.d/.git --work-tree=$HOME/.emacs.d"
    $G remote -v | grep -F 'https://github.com/Ronmi/emacs' > /dev/null 2>&1
    if [[ $? == 0 ]]
    then
	$G pull --ff-only
	exit $?
    fi

    echo "~/.emacs.d exists, aborting"
    exit 1
fi

ln -sf ~/.emacs.d/config.el ~/.emacs
