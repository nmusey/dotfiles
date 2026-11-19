{ config, lib, ... }:
let
  cfg = config.modules.services;
  redis = config.services.redis.servers.shared;
in
{
  config = lib.mkIf cfg.immich.enable {
    services.immich = {
      enable = true;
      host = "127.0.0.1";
      port = 2283;
      machine-learning.enable = cfg.immich.machineLearning;
      settings.server.externalDomain = "https://photos.${cfg.caddy.domain}";
      redis = lib.mkIf cfg.valkey.enable {
        enable = false;
        host = redis.unixSocket;
      };
    };
    users.users.immich.extraGroups = lib.mkIf cfg.valkey.enable [ redis.group ];

    modules.services.caddy.hosts.photos.port = config.services.immich.port;
  };
}
