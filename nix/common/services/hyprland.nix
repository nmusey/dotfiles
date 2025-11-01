{ config, pkgs, lib, ... }:
{
  options = {
    hyprland.enable = lib.mkEnableOption "Enable hyprland as window manager";
  };

  config = lib.mkIf config.hyprland.enable {

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    environment.systemPackages = with pkgs; [
      waybar
      hyprpaper
      mako
      rofi-wayland-unwrapped
      hyprshot
      bemoji
      pywal16
    ];
  };
}
