{ config, lib, ... }:
{
  config = lib.mkIf config.modules.services.seerr.enable {
    services.seerr = {
      enable = true;
      stateRevision = 1;
    };

    modules.services.caddy.hosts.media.port = config.services.seerr.port;
  };
}
