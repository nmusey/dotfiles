{ lib, ... }:
{
    imports = [
        ./audio.nix
        ./boot.nix
        ./networking.nix
        ./nvidia.nix
        ./user.nix
        ./settings.nix
    ];
    
    audio.enable = lib.mkDefault true;
    networking.enable = lib.mkDefault true;
}
