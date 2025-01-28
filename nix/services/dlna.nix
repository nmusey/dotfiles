{ lib, ... }:
{
  options = {
    dlna.enable = lib.mkEnableOption "enable dlna streaming server";
  };

  config = {
    services.avahi.enable = true;
    services.avahi.nssmdns4 = true;

    services.minidlna.enable = true;
    services.minidlna.openFirewall = true;
    services.minidlna.settings = {
      friendly_name = "tower";
      media_dir = [
        "V,/ssd/movies"
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
