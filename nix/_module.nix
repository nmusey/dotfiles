{ config, lib, ... }:
{
    imports = [
        ./nixos/_module.nix
        ./profiles/_module.nix
        ./programs/_module.nix
        ./services/_module.nix
    ];
}
