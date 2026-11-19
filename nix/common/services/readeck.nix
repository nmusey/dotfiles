{ config, lib, ... }:
let
  cfg = config.modules.services;
  port = 8082;
in
{
  config = lib.mkIf cfg.readeck.enable {
    services.readeck = {
      enable = true;
      environmentFile = config.variables.global.secretsFile;
      settings.server = {
        host = "127.0.0.1";
        inherit port;
        allowed_hosts = [ "read.${cfg.caddy.domain}" ];
        trusted_proxies = [ "127.0.0.1" ];
      };
    };

    modules.services.caddy.hosts.read.port = port;
  };
}
