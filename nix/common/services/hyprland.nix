{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    hyprland.enable = lib.mkEnableOption "Enable hyprland as window manager";
  };

  config = lib.mkIf config.hyprland.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    services.displayManager.ly = {
      enable = true;
      settings = {
        animation = "matrix";
        session_log = "/var/log/ly-session.log";
      };
    };

    environment.systemPackages = with pkgs; [
      hyprpaper
      hyprshot
      hyprshutdown
      grim
      slurp
      mako
      fuzzel
      bemoji
      waybar
      pywal16
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };
}
