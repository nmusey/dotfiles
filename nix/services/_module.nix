{ lib, ... }:
{
    imports = [
        ./bluetooth.nix
        ./ssh.nix
        ./dlna.nix
        ./x.nix
        ./i3.nix
        ./plasma.nix
        ./hyprland.nix
        ./eww.nix
        ./snap.nix
        ./vr.nix
    ];

    bluetooth.enable = lib.mkDefault true;
    ssh.enable = lib.mkDefault true;
    dlna.enable = lib.mkDefault false;

    x.enable = lib.mkDefault true;
    i3.enable = lib.mkDefault true;
    plasma.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault true;
}
