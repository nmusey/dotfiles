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
      hyprpaper
      mako
      fuzzel
      hyprshot
      bemoji
      pywal16
      ambxst
    ];
  };
}
