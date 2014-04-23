#!/bin/sh
D=`dirname $0`
SELF_DIR=`cd $D;pwd`

set_symlink() {
if [ ! -e ~/$1 ]; then
    echo "set symlink: $1"
    ln -s ${SELF_DIR}/$1 ~
fi
}

copy() {
if [ ! -e ~/$1 ]; then
    echo "copy: $1"
    cp -a ${SELF_DIR}/$1 ~
fi
}

make_dir() {
if [ ! -d ~/$1 ]; then
    echo "mkdir: $1"
    mkdir $1
fi
}

# zsh
curl -L http://install.ohmyz.sh | sh
echo "set symlink: .zshrc"
if [ -e ~/.zshrc ]; then
    rm ~/.zshrc
fi
ln -s ${SELF_DIR}/.zshrc ~

# mfiler2
set_symlink .mfiler
copy mint.rb

# vim
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
copy .vim
if [ ! -e ~/.vimrc ]; then
    ln -s ~/.vim/.vimrc ~
fi

# git
sudo install -m 0755 /usr/share/doc/git/contrib/diff-highlight/diff-highlight /usr/local/bin/
set_symlink .gitconfig

# ssh
copy .ssh

# tmux
set_symlink .tmux.conf

# other directories
make_dir src
