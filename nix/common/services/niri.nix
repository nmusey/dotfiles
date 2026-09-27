{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = {
    services.xserver.enable = true;
    environment.systemPackages = with pkgs; [
      niri
      waybar
      swaybg
      mako
      fuzzel
      hyprshot
      grim
      slurp
      bemoji
      hyprpaper
      awww
      eww
    ];
  };
}
