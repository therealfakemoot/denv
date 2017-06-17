#!/usr/bin/env bash

input=$@

if [ -z $1 ]; then
    echo "No utilities specified! Exiting..."
else
    case $@ in
	bash)
	    ln -vis $(pwd)/bash/bashrc       ~/.bashrc
	    ln -vis $(pwd)/bash/bash_profile ~/.bash_profile
	    ;;

	elinks)
	    ln -vis $(pwd)/elinks/elinks.conf ~/.elinks/elinks.conf
	    ;;

	emacs)
	    ln -vis $(pwd)/emacs/init.el ~/.emacs.d/init.el
	    ;;

	i3)
	    ln -vis $(pwd)/i3/config ~/.config/i3/config
	    ;;

	irssi)
	    echo "This isn't setup yet... Sorry!"
	    ;;

	tmux)
	    ln -vis $(pwd)/tmux/tmux.conf ~/.tmux.conf
	    ;;

	vim)
	    ln -vis $(pwd)/vim/vimrc ~/.vimrc
	    ;;

	zsh)
	    ln -vis $(pwd)/zsh/zshrc ~/.zshrc
	    ;;

	all|--all)
	    ln -vis $(pwd)/bash/bashrc        ~/.bashrc
	    ln -vis $(pwd)/elinks/elinks.conf ~/.elinks/elinks.conf
	    ln -vis $(pwd)/emacs/init.el      ~/.emacs.d/init.el
	    ln -vis $(pwd)/i3/config          ~/.config/i3/config
	    ln -vis $(pwd)/tmux/tmux.conf     ~/.tmux.conf
	    ln -vis $(pwd)/vim/vimrc          ~/.vimrc
	    ln -vis $(pwd)/zsh/zshrc          ~/.zshrc
	    ;;

	?|help|--help)
	    curl -sSfL https://github.com/jcmdln/denv/raw/master/Readme.md | cat
	    ;;

	*)
	    echo "You entered something invalid. Exiting..."
	    exit
	    ;;
    esac
fi
