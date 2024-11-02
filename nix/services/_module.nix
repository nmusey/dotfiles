{ lib, ... }:
{
    imports = [
        ./ssh.nix
        ./dlna.nix
    ];

    ssh.enable = lib.mkDefault true;
    dlna.enable = lib.mkDefault false;
}
