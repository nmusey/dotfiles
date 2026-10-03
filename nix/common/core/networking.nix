{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.modules.core.networking.enable {
    networking = {
      networkmanager = {
        enable = true;
        wifi.macAddress = "permanent";
        wifi.scanRandMacAddress = false;
        wifi.powersave = false;
      };

      wireless.enable = true;
      nameservers = [
        "192.168.0.123"
        "9.9.9.9"
        "94.140.14.140"
      ];

    };

    boot.kernelModules = [ "iwlwifi" ];
    hardware.firmware = [
      pkgs.linux-firmware
    ];

    time.timeZone = "America/Vancouver";
    i18n.defaultLocale = "en_CA.UTF-8";
  };
}
