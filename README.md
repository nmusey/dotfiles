# dotfiles
Setting things up the way I like it.

I also included a script to set up computers and VMs with some basics.

I'm using [Stow](https://www.gnu.org/software/stow/) to link all my dotfiles to their appropriate locations.

## Installed and Configured Programs
- `zsh`
- `neovim`
- `tmux`
- `git`

## Usage
Install scripts exist for MacOS and Ubuntu (or any Ubuntu based distros). Just clone the repo and run `setup.sh {macos,ubuntu,arch}` to install. This should also stow all the configured configuration files. 

For a manual install, `cd dotfiles` after cloning the repository, then run the following commands:
```sh
stow zsh 
stow nvim
stow tmux
stow git
```
