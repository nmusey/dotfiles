{ config, lib, ... }:
let
  cfg = config.modules.services;
  acme = cfg.caddy.dnsProvider != null;
  vhost = extraConfig: { inherit extraConfig; } // lib.optionalAttrs acme { useACMEHost = cfg.caddy.domain; };
in
{
  config = lib.mkIf cfg.caddy.enable {
    modules.services.caddy.hosts.sync = lib.mkIf config.modules.services.sync.enable { port = 8384; };

    security.acme = lib.mkIf acme {
      acceptTerms = true;
      certs.${cfg.caddy.domain} = {
        extraDomainNames = [ "*.${cfg.caddy.domain}" ];
        dnsProvider = cfg.caddy.dnsProvider;
        dnsResolver = "1.1.1.1:53";
        environmentFile = config.variables.global.secretsFile;
      };
    };

    services.caddy = {
      enable = true;
      globalConfig = lib.mkIf (!acme) "local_certs";
      virtualHosts =
        lib.mapAttrs' (
          sub: p:
          lib.nameValuePair "${sub}.${cfg.caddy.domain}" (vhost "reverse_proxy ${p.host}:${toString p.port}")
        ) cfg.caddy.hosts
        // lib.optionalAttrs (cfg.caddy.landingPage != null) {
          "${cfg.caddy.domain}, www.${cfg.caddy.domain}" = vhost ''
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
