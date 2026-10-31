{ config, lib, ... }:
let
  cfg = config.modules.services;
  port = 8083;
in
{
  config = lib.mkIf cfg.searxng.enable {
    services.searx = {
      enable = true;
      environmentFile = config.variables.global.secretsFile;
      settings = {
        server = {
          bind_address = "127.0.0.1";
          inherit port;
          base_url = "https://search.${cfg.caddy.domain}/";
          secret_key = "$SEARX_SECRET_KEY";
        };
        search.formats = [
          "html"
          "json"
        ];
      };
    };

    modules.services.caddy.hosts.search.port = port;
  };
}
