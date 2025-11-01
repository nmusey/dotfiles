{ config, lib, ... }:
{
    options.settings.enable = lib.mkEnableOption "Enable some NixOS settings";
    
    config = {
        programs.nix-ld.enable = true;
        nixpkgs.config.allowUnfree = true;
        environment.variables = {
            NIXPKGS_ALLOW_UNFREE = 1;
        };
      
        nix.settings.experimental-features = [ "nix-command" "flakes" ];
    };
}
