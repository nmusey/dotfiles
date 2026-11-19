{ config, lib, ... }:
{
  config = lib.mkIf config.modules.services.bazarr.enable {
    services.bazarr.enable = true;
    users.users.bazarr.extraGroups = [ "media" ];
    modules.services.media.enable = true;
    systemd.services.bazarr.serviceConfig.UMask = lib.mkForce "0002";

    modules.services.caddy.hosts.bazarr.port = 6767;
  };
}
