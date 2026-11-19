{ config, lib, ... }:
{
  config = lib.mkIf config.modules.services.jellyfin.enable {
    services.jellyfin = {
      enable = true;
      openFirewall = true;
    };
    users.users.jellyfin.extraGroups = [ "media" ];
    modules.services.media.enable = true;

    modules.services.caddy.hosts.watch.port = 8096;
  };
}
