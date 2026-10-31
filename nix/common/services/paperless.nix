{ config, lib, ... }:
let
  cfg = config.modules.services;
  redis = config.services.redis.servers.shared;
in
{
  config = lib.mkIf cfg.paperless.enable {
    services.paperless = {
      enable = true;
      address = "127.0.0.1";
      port = 28981;
      database.createLocally = true;
      settings = {
        PAPERLESS_URL = "https://docs.${cfg.caddy.domain}";
        PAPERLESS_OCR_LANGUAGE = "eng";
        PAPERLESS_REDIS = lib.mkIf cfg.valkey.enable "unix://${redis.unixSocket}?db=1";
      };
    };
    users.users.paperless.extraGroups = lib.mkIf cfg.valkey.enable [ redis.group ];

    modules.services.caddy.hosts.docs.port = config.services.paperless.port;
  };
}
