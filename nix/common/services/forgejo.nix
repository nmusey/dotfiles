{ config, lib, ... }:
let
  cfg = config.modules.services;
  port = 3001;
in
{
  config = lib.mkIf cfg.forgejo.enable {
    services.forgejo = {
      enable = true;
      database.type = "postgres";
      lfs.enable = true;
      settings = {
        server = {
          DOMAIN = "git.${cfg.caddy.domain}";
          ROOT_URL = "https://git.${cfg.caddy.domain}/";
          HTTP_ADDR = "127.0.0.1";
          HTTP_PORT = port;
        };
        service.DISABLE_REGISTRATION = true;
        session.COOKIE_SECURE = true;
        cache = lib.mkIf cfg.valkey.enable {
          ADAPTER = "redis";
          HOST = "network=unix,addr=${config.services.redis.servers.shared.unixSocket},db=2";
        };
      };
    };
    users.users.forgejo.extraGroups = lib.mkIf cfg.valkey.enable [ config.services.redis.servers.shared.group ];

    modules.services.caddy.hosts.git.port = port;
  };
}
