{ config, pkgs, lib, ... }:
{
  options = {
    networking.enable = lib.mkEnableOption "enable networking";
  };

  config = lib.mkIf config.networking.enable {
    networking.networkmanager.enable = true;

    time.timeZone = "America/Vancouver";
    i18n.defaultLocale = "en_CA.UTF-8";
  };
}
