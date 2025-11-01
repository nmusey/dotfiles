{ config, lib, pkgs, ... }:
{
    options = {
        niri.enable = lib.mkEnableOption "Enable niri as a window manager";
    };

    config = {
        programs.niri.enable = true;

        environment.systemPackages = with pkgs; [
            waybar
            swaybg
            mako
            fuzzel
            hyprshot
            bemoji
            hyprpaper
        ];
    };
}
