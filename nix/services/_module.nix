{ config, lib, ... }:
{
    imports = [
        ./ssh.nix
    ];

    ssh.enable = lib.mkDefault true;
}
