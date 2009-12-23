#!/bin/sh
SELF_DIR=`dirname $0`

function set_symlink() {
if [ ! -e ~/$1 ]; then
    echo "set symlink: $1"
    ln -s ${SELF_DIR}/$1 ~
fi
}

function copy {
if [ ! -e ~/$1 ]; then
    echo "copy: $1"
    cp -a ${SELF_DIR}/$1 ~
fi
}

function make_dir {
if [ ! -d ~/$1 ]; then
    echo "mkdir: $1"
    mkdir $1
fi
}

# screen
set_symlink .screenrc

# mfiler2
set_symlink .mfiler
copy mint.rb

# vim
copy .vim
make_dir .vimback
if [ ! -e ~/.vimrc ]; then
    ln -s ~/.vim/.vimrc ~
fi

# git
set_symlink .gitconfig

# ssh
copy .ssh

# other directories
make_dir src
make_dir projects
