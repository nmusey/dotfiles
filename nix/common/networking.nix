{ config, pkgs, lib, ... }:
{
  options = {
    networking.enable = lib.mkEnableOption "enable networking";
  };

  config = lib.mkIf config.networking.enable {
    networking.networkmanager.enable = true;
    networking.nameservers = [
        "10.0.0.124"
        "1.1.1.1"
        "8.8.8.8"
    ];

    time.timeZone = "America/Vancouver";
    i18n.defaultLocale = "en_CA.UTF-8";
  };
}
