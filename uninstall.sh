#!/usr/bin/env sh


warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

rm $HOME/.vimrc
rm $HOME/.vimrc.local
rm $HOME/.vimrc.plugs
rm $HOME/.vimrc.md
rm $HOME/.config/nvim/init.vim

rm -rf $HOME/.vim
rm -rf $HOME/.gvim
rm -rf $HOME/.nvim
