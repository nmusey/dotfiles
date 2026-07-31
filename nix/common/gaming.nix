{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    gaming.enable = lib.mkEnableOption "enables gaming packages";
  };

  config = lib.mkIf config.gaming.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };

    environment.systemPackages = with pkgs; [
      lutris
      prismlauncher
      wine
    ];
  };
}
