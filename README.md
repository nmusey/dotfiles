# dotfiles
Setting things up the way I like it.

I also included a script to set up computers and VMs with some basics.

I'm using [Stow](https://www.gnu.org/software/stow/) to link all my dotfiles to their appropriate locations.

## Installed and Configured Programs
- `zsh`
- `neovim`
- `tmux`
- `git`
- `kitty`
- A couple tiling window managers for Linux systems.

## Usage
To install, run `./setup [OS]` where the OS is `macos`, `ubuntu`, or `arch`.

To only use a single program, stow that directory. For example, `stow nvim` will stow neovim files.
