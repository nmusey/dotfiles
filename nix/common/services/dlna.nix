{ config, lib, ... }:
{
  config = lib.mkIf config.modules.services.dlna.enable {
    services.avahi.enable = config.modules.services.dlna.enable;
    services.avahi.nssmdns4 = config.modules.services.dlna.enable;

    services.minidlna.enable = config.modules.services.dlna.enable;
    services.minidlna.openFirewall = config.modules.services.dlna.enable;
    services.minidlna.settings = {
      friendly_name = "tower";
      media_dir = [
        "V,/srv/Videos"
      ];

      inotify = "yes";
      log_level = "info";
      notify_interval = 1;
    };

    users.users.minidlna = {
      extraGroups = [
        "wheel"
        "minidlna"
        "dlna"
        "srv"
      ];
    };

    users.users.${config.variables.global.username}.extraGroups = [ "dlna" ];

    systemd.tmpfiles.rules = [
      "d /srv/Videos/ 2755 ${config.variables.global.username} dlna -"
    ];

    networking.firewall.allowedTCPPorts = [
      139
      445
      8096
    ];
    networking.firewall.allowedUDPPorts = [
      137
      138
      1900
    ];
  };
}
