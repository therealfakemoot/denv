## denv - My Development Environment (and other configurations)

Note: This repository exists mainly for archival purposes and is not intended for use by others. 
Simply use what is here as an example and RTFM for what it does.


## Overview

### bash
I mainly install `bash-completion` and setup my `~/.bashrc` as well as `~/.bash_profile` with 
the standard things such as encoding, language, and etc. Nothing too fancy.

### emacs
Wouldn't recommend this for new users or purists, it's too specific to my former tmux/vim 
workflow though I don't use `evil`. If you would like to try it, simply move your `.emacs.d`
somewhere else and place `init.el` in a new, empty `.emacs.d`. It will download packages
automatically thanks to `use-package` and the configuration is built into the `use-package`
definitions. I would highly recommend reading `init.el` before using it, as you most likely 
wouldn't use more than half of what is in it.

## tmux
I added some "faster" keybinds and a basic theme. `tmux` is perfectly fine without this.

## vim
My ideal vim configuration using `plug` to automatically install packages with configuration
built in. This should be suitable for novice vim users.

## zsh
Almost a copy/paste from my bashrc, though I'm using `oh-my-zsh`.
