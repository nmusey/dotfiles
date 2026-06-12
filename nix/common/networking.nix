{ config, pkgs, lib, ... }:
{
  options = {
    networking.enable = lib.mkEnableOption "enable networking";
  };

  config = lib.mkIf config.networking.enable {
    networking.networkmanager.enable = true;
    networking.nameservers = [
        "192.168.0.123"
        "8.8.8.8"
        "1.1.1.1"
    ];

    time.timeZone = "America/Vancouver";
    i18n.defaultLocale = "en_CA.UTF-8";
  };
}
