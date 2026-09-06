{ ... }:
{
  imports = [
    ./ai.nix
    ./audio.nix
    ./boot.nix
    ./developer.nix
    ./gaming.nix
    ./networking.nix
    ./nvidia.nix
    ./settings.nix
    ./user.nix
    ./work.nix
    ./zsa.nix

    ./dev/c.nix
    ./dev/dotnet.nix
    ./dev/go.nix
    ./dev/godot.nix
    ./dev/javascript.nix
    ./dev/lua.nix
    ./dev/nix.nix
    ./dev/rust.nix
    ./dev/unity.nix
    ./dev/zig.nix

    ./programs/desktop.nix
    ./programs/git.nix
    ./programs/kanata.nix
    ./programs/neovim.nix
    ./programs/openrgb.nix
    ./programs/quickshell.nix
    ./programs/zsh.nix

    ./services/bluetooth.nix
    ./services/dlna.nix
    ./services/docker.nix
    ./services/hyprland.nix
    ./services/i3.nix
    ./services/niri.nix
    ./services/nordvpn.nix
    ./services/plasma.nix
    ./services/ssh.nix
    ./services/tailscale.nix
    ./services/x.nix
  ];
}
