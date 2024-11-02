{ lib, config, pkgs, ... }:
{
  options = {
    openrgb.enable = lib.mkEnableOption "enable openrgb";
  };

  config = lib.mkIf config.openrgb.enable {
    environment.systemPackages = with pkgs; [
      (openrgb.overrideAttrs (oldAttrs: {
        postInstall = ''
          wrapProgram $out/bin/openrgb --set WAYLAND_DISPLAY ""
        '';
      }))
    ];

    services.udev.packages = [ pkgs.openrgb ];

    environment.etc."udev/rules.d/60-openrgb.rules".text = ''
      SUBSYSTEM=="i2c-dev", MODE="0666"
      SUBSYSTEM=="spi", MODE="0666"
    '';
  };
}
