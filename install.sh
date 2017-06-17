#!/usr/bin/env sh

Bash() {
    ln -vis $(pwd)/bash/bashrc       ~/.bashrc
    ln -vis $(pwd)/bash/bash_profile ~/.bash_profile
}

Elinks() {
    if [ -z ~/.elinks ]; then mkdir -vpi ~/.elinks; fi
    ln -vis $(pwd)/elinks/elinks.conf ~/.elinks/elinks.conf
}

Emacs() {
    if [ -z ~/.emacs.d ]; then mkdir -vpi ~/.emacs.d/; fi
    ln -vis $(pwd)/emacs/init.el ~/.emacs.d/init.el
}

I3()    {
    if [ -z ~/.config/i3 ]; then mkdir -vpi ~/.config/i3; fi
    ln -vis $(pwd)/i3/config ~/.config/i3/config
}

Irssi() { echo "This isn't setup yet... Sorry!" }
Tmux()  { ln -vis $(pwd)/tmux/tmux.conf ~/.tmux.conf }
Vim()   { ln -vis $(pwd)/vim/vimrc ~/.vimrc }
Zsh()   { ln -vis $(pwd)/zsh/zshrc ~/.zshrc }

if [ -z $1 ]; then
    echo "No utilities specified! Exiting..."
else
    for flag in $@; do
	case $flag in
	    bash)   $Bash;;
	    elinks) $Elinks;;
	    emacs)  $Emacs;;
	    i3)     $I3;;
	    irssi)  $Irssi;;
	    tmux)   $Tmux;;
	    vim)    $Vim;;
	    zsh)    $Zsh;;

	    all)
		$Bash
		$Elinks
		$Emacs
		$I3
		$Irssi
		$Tmux
		$Vim
		$Zsh
		;;

	    help|--help)
		curl -sSfL https://github.com/jcmdln/denv/raw/master/Readme.md | cat
		;;

	    *)
		echo "You entered something invalid. Exiting..."
		exit
		;;
	esac
    done
fi
