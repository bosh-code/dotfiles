# dotfiles

An endless mess of aliases and .ignores

Mostly based on https://github.com/mattmc3's dotfiles & zdotdir

## setup:

the script backs up and deletes `~/.config/`, `~/.ssh/` and `~/.local/share` before replacing them with symlinks, do not forget this. Run this on a fresh machine or copy stuff over from the backups.

```shell
git clone https://github.com/bosh-code/dotfiles ~/.dotfiles
cd ~/.dotfiles && ./setup.sh

```
