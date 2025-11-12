{ config, lib, ... }:
{
    options.settings.enable = lib.mkEnableOption "Enable some NixOS settings";
    
    config = {
        programs.nix-ld.enable = true;
        nixpkgs.config.allowUnfree = true;
        nixpkgs.config.allowBroken = true;
        environment.variables = {
            NIXPKGS_ALLOW_UNFREE = 1;
        };
      
        nix.settings.experimental-features = [ "nix-command" "flakes" ];

        services.envfs.enable = true;
        system.autoUpgrade.enable = true;
        system.autoUpgrade.channel = "https://channels.nixos.org/nixos-unstable";
    };
}
