{ config, lib, ... }:
let
  cfg = config.modules.services;
in
{
  config = lib.mkIf cfg.caddy.enable {
    modules.services.caddy.hosts.sync = lib.mkIf config.modules.services.sync.enable { port = 8384; };

    services.caddy = {
      enable = true;
      globalConfig = "local_certs";
      virtualHosts =
        lib.mapAttrs' (
          sub: p:
          lib.nameValuePair "${sub}.${cfg.caddy.domain}" {
            extraConfig = "reverse_proxy ${p.host}:${toString p.port}";
          }
        ) cfg.caddy.hosts
        // lib.optionalAttrs (cfg.caddy.landingPage != null) {
          "${cfg.caddy.domain}, www.${cfg.caddy.domain}".extraConfig = ''
            root * ${cfg.caddy.landingPage}
            file_server
          '';
        };
    };

    networking.firewall = {
      allowedTCPPorts = [ 80 443 ];
      allowedUDPPorts = [ 443 ];
    };
  };
}
