{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../_module.nix
  ];

  config = {
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };

    networking.hostName = "fool";
    hardware = {
      graphics.enable = true;
      keyboard.zsa.enable = true;
    };

    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

    boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];
    environment.variables = {
      QT_QPA_PLATFORM = "wayland;xcb";
    };

    ai.enable = true;
    personal.enable = true;
    developer.enable = true;
    gaming.enable = false;
    openrgb.enable = false;
  };
}
