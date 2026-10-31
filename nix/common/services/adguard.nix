{ config, lib, ... }:
let
  cfg = config.modules.services;
  port = 3002;
in
{
  config = lib.mkIf cfg.adguard.enable {
    services.adguardhome = {
      enable = true;
      settings = {
        http.address = "127.0.0.1:${toString port}";
        dns = {
          bind_hosts = [ "0.0.0.0" ];
          port = 53;
          upstream_dns = [
            "https://dns.quad9.net/dns-query"
            "https://dns.adguard-dns.com/dns-query"
          ];
          bootstrap_dns = [
            "9.9.9.9"
            "94.140.14.140"
          ];
        };
        filtering = {
          protection_enabled = true;
          filtering_enabled = true;
          rewrites = map (domain: {
            inherit domain;
            answer = cfg.caddy.address;
            enabled = true;
          }) [ cfg.caddy.domain "*.${cfg.caddy.domain}" ];
        };
        filters = [
          {
            enabled = true;
            id = 1;
            name = "AdGuard DNS filter";
            url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt";
          }
        ];
      };
    };

    networking.firewall = {
      allowedTCPPorts = [ 53 ];
      allowedUDPPorts = [ 53 ];
    };

    modules.services.caddy.hosts.adguard.port = port;
  };
}
