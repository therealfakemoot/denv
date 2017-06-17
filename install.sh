#!/usr/bin/env bash

input=$@

if [ -z $1 ]; then
    echo "No utilities specified! Exiting..."
else
    case $@ in
	bash)
	    ln -sf $(pwd)/bash/bashrc ~/.bashrc \
		&& echo "Done!"
	    ;;

	elinks)
	    ln -sf $(pwd)/elinks/elinks.conf ~/.elinks/elinks.conf \
		&& echo "Done!"
	    ;;

	emacs)
	    ln -sf $(pwd)/emacs/init.el ~/.emacs.d/init.el \
		&& echo "Done!"
	    ;;

	i3)
	    ln -sf $(pwd)/i3/config ~/.config/i3/config \
		&& echo "Done!"
	    ;;

	irssi)
	    echo "This isn't setup yet... Sorry!"
	    ;;

	tmux)
	    ln -sf $(pwd)/tmux/tmux.conf ~/.tmux.conf \
		&& echo "Done!"
	    ;;

	vim)
	    ln -sf $(pwd)/vim/vimrc ~/.vimrc \
		&& echo "Done!"
	    ;;

	zsh)
	    ln -sf $(pwd)/zsh/zshrc ~/.zshrc \
		&& echo "Done!"
	    ;;

	all|--all)
	    echo "Installing all configs..." \
		&& ln -sf $(pwd)/bash/bashrc        ~/.bashrc \
		&& ln -sf $(pwd)/elinks/elinks.conf ~/.elinks/elinks.conf \
		&& ln -sf $(pwd)/emacs/init.el      ~/.emacs.d/init.el \
		&& ln -sf $(pwd)/i3/config          ~/.config/i3/config \
		&& ln -sf $(pwd)/tmux/tmux.conf     ~/.tmux.conf \
		&& ln -sf $(pwd)/vim/vimrc          ~/.vimrc \
		&& ln -sf $(pwd)/zsh/zshrc          ~/.zshrc
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
