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

    # ly drops to user before making ly-session.log so extra permissions are needed
    systemd.tmpfiles.rules = [
      "f /var/log/ly-session.log 0666 root root -"
    ];

    systemd.user.targets.hyprland-session = {
      description = "Hyprland compositor session";
      documentation = [ "man:systemd.special(7)" ];
      bindsTo = [ "graphical-session.target" ];
      wants = [ "graphical-session-pre.target" ];
      after = [ "graphical-session-pre.target" ];
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
    ];

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];

      config.common.default = [
        "hyprland"
        "gtk"
      ];
    };
  };
}
