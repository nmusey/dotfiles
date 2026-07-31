# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles + NixOS system configuration for multiple machines. Two layers work together:

1. **`nix/`** — NixOS modules that install and enable programs/services at the OS level (declarative, per-host).
2. **Top-level directories** (`zsh/`, `nvim/`, `hypr/`, `waybar/`, `git/`, `tmux/`, `ghostty/`, `fuzzel/`, `fastfetch/`, `ripgrep/`, `bin/`) — actual dotfiles/config files, deployed with [GNU Stow](https://www.gnu.org/software/stow/).

A NixOS module (e.g. `nix/common/programs/neovim.nix`) enables the *package*; the corresponding top-level directory (e.g. `nvim/`) supplies the *config* that gets symlinked into `$HOME` by Stow. When changing a program's behavior, check whether you need to edit the Nix module (install/service config), the stowed dotfile (app config), or both.

## Commands

- **Stow a single package**: `stow <name>` from the repo root (e.g. `stow nvim`, `stow zsh`). Symlinks `<name>/.config/...` etc. into `$HOME`.
- **Full setup**: `./setup [macos|ubuntu|arch]`. Note: this currently expects an `./install/os/<os>` script that is not present in the repo — treat `./setup` as unreliable/stale until that's restored, and prefer Stow + manual NixOS rebuild for actual changes.
- **Rebuild a NixOS host** (run on that host, from `nix/hosts/<host>/`): `sudo nixos-rebuild switch --flake .#<host>` (hosts: `tower`, `fool`, `virtual`).
- **Build without switching** (useful for validating changes): `nixos-rebuild build --flake .#<host>` — produces a `result` symlink in that host's directory; this is a local build artifact, not something to commit.
- **Format Nix files**: `nixfmt` (used repo-wide; see the "Run nixfmt" commit for precedent — run it over any `.nix` files you touch).
- **Update flake inputs** for a host: `nix flake update` from within `nix/hosts/<host>/`.

There is no test suite, linter, or CI in this repo — correctness is validated by `nixos-rebuild build`/`switch` succeeding and by manually checking the deployed dotfiles.

## Nix module architecture

- `nix/common/include.nix` is the aggregator: it imports every reusable module in `nix/common/` (top-level concerns, `dev/`, `programs/`, `services/`). Adding a new common module means creating the file *and* adding it to this import list.
- Every module follows the same shape: it declares one `lib.mkEnableOption` (e.g. `options.docker.enable`), and wraps its actual config in `lib.mkIf config.<name>.enable`. Nothing is on by default — hosts opt in explicitly.
- `nix/hosts/<host>/configuration.nix` imports `../../common/include.nix` and then flips on the specific set of `*.enable` options that host needs (e.g. `tower` enables `gaming`, `nvidia`, `plasma`; `virtual` and `fool` don't). When adding a new module/option, remember to also enable it in whichever host configs should use it — it won't turn on by itself.
- `nix/common/dev/*.nix` are per-language toolchains (go, rust, javascript, lua, c, dotnet, zig, nix, godot, unity); `nix/common/programs/*.nix` are user-facing apps (git, zsh, neovim, kanata, openrgb, desktop); `nix/common/services/*.nix` are system services/window managers (hyprland, niri, i3, plasma, x, docker, bluetooth, ssh, dlna, vr).
- Each host directory (`nix/hosts/<host>/`) is its own flake with its own `flake.nix`/`flake.lock` and `hardware-configuration.nix` (except `virtual`, which has none since it's a VM). Flake inputs (e.g. `zen-browser`) are declared per-host, not centrally.
- `nix/common/user.nix` hardcodes the user `nick`; `nix/common/work.nix` (katipult) references `config.username`, which isn't actually defined anywhere else in the repo — be aware of this mismatch if touching that module.

## Dotfile packages

- Each top-level directory mirrors the `$HOME` layout it targets (e.g. `nvim/.config/nvim/...`, `bin/.local/bin/...`), which is what makes `stow <name>` work correctly from the repo root.
- `zsh/.zshrc` sources `~/.theme.zsh` (pywal-based theming) and an optional `~/.local.zshrc` for machine-specific overrides/aliases — don't bake host-specific settings into the tracked `.zshrc`.
- `hypr/.config/hypr/hyprland.lua` config is Lua-based (not the usual `hyprland.conf`).
- `.gitignore` excludes `zsh/local.zshrc`, `nvim/.config/coc`, `nvim/.config/nvim/plugin`, `.env`, `nerd-fonts`, and `bin/.local/var` — these are local/generated and shouldn't be committed.
