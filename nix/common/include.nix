{ ... }:
{
    imports = [
        ./ai.nix
        ./audio.nix
        ./boot.nix
        ./developer.nix
        ./gaming.nix
        ./moonlander.nix
        ./networking.nix
        ./nvidia.nix
        ./settings.nix
        ./user.nix
        ./virtualization.nix
        ./work.nix

        ./dev/dotnet.nix
        ./dev/go.nix
        ./dev/javascript.nix
        ./dev/lua.nix
        ./dev/rust.nix

        ./programs/git.nix
        ./programs/neovim.nix
        ./programs/openrgb.nix
        ./programs/zsh.nix

        ./services/bluetooth.nix
        ./services/dlna.nix
        ./services/docker.nix
        ./services/hyprland.nix
        ./services/i3.nix
        ./services/niri.nix
        ./services/plasma.nix
        ./services/ssh.nix
        ./services/x.nix
    ];
}
