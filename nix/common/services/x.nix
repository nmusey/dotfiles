{ config, pkgs, lib, ... }:
{
    options = {
        x.enable = lib.mkEnableOption "Enable X";
    };

    config = lib.mkIf config.x.enable {
        services.xserver.enable = true;
        services.displayManager.ly = {
            enable = true;
        };

        services.xserver.xkb = {
          layout = "us";
          variant = "";
        };
        
        environment.systemPackages = with pkgs; [
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
