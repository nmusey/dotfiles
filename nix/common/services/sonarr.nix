{ config, lib, ... }:
{
  config = lib.mkIf config.modules.services.sonarr.enable {
    services.sonarr.enable = true;
    users.users.sonarr.extraGroups = [ "media" ];
    modules.services.media.enable = true;
    systemd.services.sonarr.serviceConfig.UMask = lib.mkForce "0002";

    modules.services.caddy.hosts.sonarr.port = 8989;
  };
}
