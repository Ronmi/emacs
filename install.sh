#!/bin/bash

REPO='https://github.com/Ronmi/emacs'
DIR="$HOME/.emacs.d"

which git > /dev/null 2>&1
if  [[ $? != 0 ]]
then
    echo 'You must install git before using my emacs setup.'
    exit 1
fi

if [[ -d "$DIR" ]]
then
    G="git -C $DIR"
    $G remote -v | grep -F "$REPO" > /dev/null 2>&1
    if [[ $? == 0 ]]
    then
	$G pull --ff-only
	exit $?
    fi

    echo "$DIR exists, aborting"
    exit 1
fi

# do not clobber an existing ~/.emacs unless it already points to us
if [[ -e ~/.emacs || -L ~/.emacs ]] && [[ "$(readlink ~/.emacs)" != "$DIR/config.el" ]]
then
    echo "~/.emacs exists, aborting"
    exit 1
fi

git clone "$REPO" "$DIR" || exit 1
ln -sf "$DIR/config.el" ~/.emacs
# config.el always loads custom.el, which holds per-machine settings
touch "$DIR/custom.el"
