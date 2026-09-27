{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.modules.services.i3.enable {
    environment.pathsToLink = [ "/libexec" ];
    services.xserver = {
      enable = true;

      desktopManager = {
        xterm.enable = false;
      };

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          i3status
          i3a
        ];
      };
    };
  };
}
