{ config, lib, ... }:
{
  config = lib.mkIf config.modules.services.prowlarr.enable {
    services.prowlarr.enable = true;
    services.flaresolverr.enable = true;

    modules.services.caddy.hosts.prowlarr.port = 9696;
  };
}
