{ config, lib, pkgs, ... }:
{
  config = lib.mkIf config.modules.services.valkey.enable {
    services.redis.package = pkgs.valkey;
    services.redis.servers.shared = {
      enable = true;
      port = 0;
    };
  };
}
