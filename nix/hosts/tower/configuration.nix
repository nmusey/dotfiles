{ config, pkgs, ... }:
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

    networking.hostName = "tower";
    hardware = {
      graphics.enable = true;
      keyboard.zsa.enable = true;
    };

    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

    ai.enable = true;
    personal.enable = true;
    developer.enable = true;
    gaming.enable = true;
    katipult.enable = true;
  };
}
