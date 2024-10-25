{ config, pkgs, lib, ... }:
{
  options = {
    window-manager.enable = lib.mkEnableOption "Enable a display manager";
  };

  config = lib.mkIf config.window-manager.enable {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.displayManager.gdm.wayland = true;
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    services.desktopManager.plasma6.enable = true;

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    services.displayManager.defaultSession = "hyprland";

    environment.systemPackages = with pkgs; [
      waybar
      fuzzel
      hyprpaper
      mako
      dunst
      rofi-wayland-unwrapped
      hyprshot

      xorg.libX11
      xorg.libXext
      xorg.libXrandr
      xorg.libXi
      xorg.libXcursor
      xorg.libXinerama
      xorg.libXrender
    ];
  };
}
