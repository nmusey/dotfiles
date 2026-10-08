{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.modules.core.gaming.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };
    
    environment.sessionVariables = {
      PROTONPATH = "GE-Proton";
    };

    environment.systemPackages = with pkgs; [
      lutris
      prismlauncher
      wine64
      winetricks
      umu-launcher
    ];
  };
}
