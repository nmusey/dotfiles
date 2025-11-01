{ config, pkgs, lib, ... }:
{
    options = {
        i3.enable = lib.mkEnableOption "Enable i3 as a window manager";
    };

    config = lib.mkIf config.i3.enable {
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
