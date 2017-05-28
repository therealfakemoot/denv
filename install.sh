#!/bin/sh

cdur=`pwd`

#ln -sf $cdur/bash/bashrc
ln -sf $cdur/emacs/init.el  ~/.emacs.d/init.el
ln -sf $cdur/tmux/tmux.conf ~/.tmux.conf
ln -sf $cdur/vim/vimrc      ~/.vimrc
