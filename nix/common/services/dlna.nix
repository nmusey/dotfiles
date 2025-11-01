{ config, lib, ... }:
{
  options = {
    dlna.enable = lib.mkEnableOption "enable dlna streaming server";
  };

  config = lib.mkIf config.dlna.enable {
    services.avahi.enable = config.dlna.enable;
    services.avahi.nssmdns4 = config.dlna.enable;

    services.minidlna.enable = config.dlna.enable;
    services.minidlna.openFirewall = config.dlna.enable;
    services.minidlna.settings = {
      friendly_name = "tower";
      media_dir = [
        "V,/home/minidlna/Downloads/"
      ];

      inotify = "yes";
      log_level = "info";
      announceInterval = 05;
    };

    users.users.minidlna = {
      extraGroups =
        [ "users" "wheel" "minidlna" ];
    };

    networking.firewall.allowedTCPPorts = [ 139 445 8096 ];
    networking.firewall.allowedUDPPorts = [ 137 138 1900 ];
  };
}
