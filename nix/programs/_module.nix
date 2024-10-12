{ lib, ... }:
{
    imports = [
        ./git.nix
        ./zsh.nix
    ];

    config = {
        git.enable = lib.mkDefault true;
        zsh.enable = lib.mkDefault true;
    };
}
