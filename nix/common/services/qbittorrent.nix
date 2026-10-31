{
  config,
  lib,
  options,
  ...
}:
let
  cfg = config.modules.services;
  hasVpnConfinement = options ? vpnNamespaces;
  vpn =
    if hasVpnConfinement then
      config.vpnNamespaces.proton
    else
      {
        namespaceAddress = "127.0.0.1";
        bridgeAddress = "127.0.0.1";
      };
  port = 8080;
in
{
  config = lib.mkIf cfg.qbittorrent.enable (
    lib.mkMerge [
      {
        assertions = [
          {
            assertion = hasVpnConfinement;
            message = "modules.services.qbittorrent needs the VPN-Confinement nixos module imported by the host flake";
          }
        ];

        services.qbittorrent = {
          enable = true;
          webuiPort = port;
          serverConfig = {
            LegalNotice.Accepted = true;
            BitTorrent.Session.DefaultSavePath = "${cfg.media.dir}/downloads";
            Preferences.WebUI = {
              ReverseProxySupportEnabled = true;
              TrustedReverseProxiesList = vpn.bridgeAddress;
            };
          };
        };
        users.users.qbittorrent.extraGroups = [ "media" ];
        modules.services.media.enable = true;

        systemd.services.qbittorrent.serviceConfig.UMask = lib.mkForce "0002";

        modules.services.caddy.hosts.qbittorrent = {
          host = vpn.namespaceAddress;
          inherit port;
        };
      }
      (lib.optionalAttrs hasVpnConfinement {
        vpnNamespaces.proton = {
          enable = true;
          wireguardConfigFile = cfg.qbittorrent.wireguardConfigFile;
          portMappings = [
            {
              from = port;
              to = port;
            }
          ];
        };

        systemd.services.qbittorrent.vpnConfinement = {
          enable = true;
          vpnNamespace = "proton";
        };
      })
    ]
  );
}
