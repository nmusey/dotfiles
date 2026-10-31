{ config, lib, ... }:
{
  config = lib.mkIf config.modules.services.radarr.enable {
    services.radarr.enable = true;
    users.users.radarr.extraGroups = [ "media" ];
    modules.services.media.enable = true;
    systemd.services.radarr.serviceConfig.UMask = lib.mkForce "0002";

    modules.services.caddy.hosts.radarr.port = 7878;
  };
}
