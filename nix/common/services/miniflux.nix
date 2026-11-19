{ config, lib, ... }:
let
  cfg = config.modules.services;
  port = 8081;
in
{
  config = lib.mkIf cfg.miniflux.enable {
    services.miniflux = {
      enable = true;
      adminCredentialsFile = config.variables.global.secretsFile;
      config = {
        LISTEN_ADDR = "127.0.0.1:${toString port}";
        BASE_URL = "https://rss.${cfg.caddy.domain}/";
      };
    };

    modules.services.caddy.hosts.rss.port = port;
  };
}
