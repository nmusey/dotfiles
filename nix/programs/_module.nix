{ lib, ... }:
{
    imports = [
        ./git.nix
        ./zsh.nix
        ./openrgb.nix
        ./neovim.nix
    ];

    config = {
        git.enable = lib.mkDefault true;
        zsh.enable = lib.mkDefault true;
        neovim.enable = lib.mkDefault true;
        openrgb.enable = lib.mkDefault false;
    };
}
