Note: This repository exists mainly for archival purposes and is not
intended for use by others. It would be best to use the configurations
as example material and simply impart the ideas into your own.


## Install ########################################

You may install any specific config by naming it's parent-level folder
(which shares the same name as the utility itself) and this will create
a symlink in the target location. Please note that this is primarly
tested on Fedora and Archlinux; review the install script beforehand or
install the desired config files manually.

### Quick Install
```
# Clone repo and cd into it
git clone https://github.com/jcmdln/denv.git
cd ./denv

# Install items in flag 'all' (all listed in Overview)
sh ./install.sh all

# Install item by name, prompt before replacing
sh ./install.sh bash
sh ./install.sh tmux vim
```


## Overview ######################################

A quick synopis of the purpose of each configuration is provided, though
please review the configurations you plan to use directly.

### bash
I mainly install `bash-completion` and setup my `~/.bashrc` as well as
`~/.bash_profile` with the standard things such as encoding, language,
and etc. Nothing too fancy.

### emacs
I've set aside an entire section to setting 'better defaults' which is
an opinionated assortment of preferred behavior. Packages are
automatically downloaded and installed from Melpa's stable branch thanks
to `use-package`, and the configuration for each utility is defined
within it's `use-package` declaration.

### i3
I started with the default config, cleaned it up, added support for
media keys, as well as a proper system prompt to lock the screen or
restart.

### tmux
I added some "faster" keybinds and a basic theme. `tmux` is perfectly
fine without this.

### vim
My ideal vim configuration using `plug` to automatically install
packages which have a minimalist configuration.

### zsh
Almost a copy/paste from my bashrc, though I'm using `oh-my-zsh`. It
will automatically install `oh-my-zsh` by downloading it's install
script if `~/.oh-my-zsh` does not exist.


## Extras ########################################

Optional configuration files

### Apache
### Caddy
### Docker
### Nginx
