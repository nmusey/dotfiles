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
      };
    };

    environment.systemPackages = with pkgs; [
      hyprpaper
      hyprshot
      hyprshutdown
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
