{ config, pkgs, lib, ... }:
{
    options = {
        gaming.enable = lib.mkEnableOption "enables gaming packages";
    };

    config = lib.mkIf config.gaming.enable {
        programs.steam.enable = true;
        programs.steam.gamescopeSession.enable = true;

        environment.systemPackages = with pkgs; [
            lutris
            prismlauncher
            wine
        ];
    };
  };
}
