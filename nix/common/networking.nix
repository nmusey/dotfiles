{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    networking.enable = lib.mkEnableOption "enable networking";
  };

  config = lib.mkIf config.networking.enable {
    networking = {
      networkmanager = {

        enable = true;
        wifi.macAddress = "permanent";
        wifi.scanRandMacAddress = false;
        wifi.powersave = true;
      };
      wireless.enable = true;
      dhcpcd.enable = true;
      nameservers = [
        "192.168.0.123"
        "8.8.8.8"
        "1.1.1.1"
      ];
    };

    boot.kernelModules = [ "iwlwifi" ];
    networking.networkmanager.ethernet.macAddress = "permanent";

    hardware.firmware = [
      pkgs.linux-firmware
    ];

    time.timeZone = "America/Vancouver";
    i18n.defaultLocale = "en_CA.UTF-8";
  };
}
