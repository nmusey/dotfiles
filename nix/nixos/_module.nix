{ lib, ... }:
{
    imports = [
        ./audio.nix
        ./boot.nix
        ./networking.nix
        ./nvidia.nix
        ./user.nix
        ./settings.nix
        ./window-manager.nix
    ];
    
    audio.enable = lib.mkDefault true;
    networking.enable = lib.mkDefault true;
    window-manager.enable = lib.mkDefault true;
}
