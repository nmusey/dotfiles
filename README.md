# dotfiles
Setting things up the way I like it.

The configurations provide a minimal terminal-centric development environment. I work across macos and NixOS mostly so those are the configured environments, but this can easily be adapted to any Unix based OS.

I'm using [Stow](https://www.gnu.org/software/stow/) to link all my dotfiles to their appropriate locations. This allows for easy linking of files in this repository while maintaining the flexibility to adapt to subsets of preferred tools on other machines.
`man stow` gives more information about the program and usage.

## Setup
After following the below steps to install programs and link configuration files, there are a few optional steps on a per-machine basis.

- `touch ~/.local.zshrc` to create a local shell configuration for environment variables or specific commands that won't be used on other machines.
- `git config edit --global` to double check the correct names are in there.

### Installing programs
NixOS and macos have pre-configured ways to install configured programs.
Other Linux distros are easily usable but programs vary by package manager.

#### NixOS
```sh
cd nix/hosts/{hostname}
sudo nixos-rebuild switch --flake .
```

##### Adding a host
TODO - Add these docs

#### macos
A brewfile is included for easy installation. This theoretically works on supported Linux distros too, but those should have a decent package manager built-in already.
```sh
brew bundle install
```

### Stow with configuration files
GNU stow can be called with `stow {dirname}` to configure a single program. For convenience, copy/paste desired commands below.

**Development Programs**
```sh
stow bin ghostty git nvim ripgrep tmux zsh
```

**Linux Window Manager Programs** (run in addition to development programs)
```sh
stow fastfetch fuzzel hypr quickshell waybar
```

## Installed and Configured Programs
### Fastfetch
See some system info. I don't use it much but is it a dotfile repo without a fetch program?

### Fuzzel
A launcher, essentially a prettier dmenu.

### Ghostty
A terminal emulator that does just enough things without too many extra things. Also available on multiple platforms.

### Git
System defaults for git on this machine.

### Hypr
The Hyprland ecosystem configs. Includes the lockscreen and wallpaper manager configurations as well as the window manager.

### Neovim
A muscle-memory and keyboard driven modal text editor.

### Quickshell
A UI layer for window managers, specifically to make Hyprland pretty in this case.

### Ripgrep
Faster and modern grep alternative.

### tmux
Terminal multiplexer, launch it through `t` and `ta` utilities if using the zsh configs.

### Waybar
I'm deprecating waybar in favor of Quickshell but am keeping the reference configs here until I'm done the migration.

### zsh
Shell aliases, configs, etc. These are only loaded if the program exists so they shouldn't cause warnings or errors.
