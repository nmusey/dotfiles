{ lib, ... }:
{
  options.modules.services = {
    adguard.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable AdGuard Home ad-blocking dns and local name resolution";
    };
    audiobookshelf.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable Audiobookshelf audiobook and podcast server";
    };
    bazarr.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable Bazarr subtitle downloader";
    };
    bluetooth.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable bluetooth server";
    };
    caddy = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "enable Caddy reverse proxy for the self-hosted services";
      };
      domain = lib.mkOption {
        type = lib.types.str;
        default = "home.lan";
        description = "domain every proxied service is served under";
      };
      address = lib.mkOption {
        type = lib.types.str;
        default = "127.0.0.1";
        description = "lan address that the domain and its subdomains resolve to";
      };
      dnsProvider = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        example = "namecheap";
        description = "lego dns provider for a let's encrypt wildcard certificate, credentials read from the secrets file; null uses caddy's local ca";
      };
      landingPage = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
        description = "directory of static files served at the bare domain";
      };
      hosts = lib.mkOption {
        type = lib.types.attrsOf (
          lib.types.submodule {
            options = {
              host = lib.mkOption {
                type = lib.types.str;
                default = "127.0.0.1";
                description = "address the service listens on";
              };
              port = lib.mkOption {
                type = lib.types.port;
                description = "port the service listens on";
              };
            };
          }
        );
        default = { };
        description = "subdomains reverse proxied to local services";
      };
    };
    dlna.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable dlna streaming server";
    };
    docker.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable Docker and related tools";
    };
    forgejo.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable Forgejo git hosting";
    };
    homeassistant.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable Home Assistant bridged to Apple Home";
    };
    hyprland.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable hyprland as window manager";
    };
    i3.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable i3 as a window manager";
    };
    immich = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "enable Immich photo library";
      };
      machineLearning = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "enable Immich's machine learning (smart search, faces)";
      };
    };
    jellyfin.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable Jellyfin media server";
    };
    media = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "enable the shared media group and library directories";
      };
      dir = lib.mkOption {
        type = lib.types.str;
        default = "/srv/media";
        description = "root of the media library and torrent downloads";
      };
    };
    miniflux.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable Miniflux rss reader";
    };
    musicassistant.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable Music Assistant";
    };
    navidrome.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable Navidrome music streaming";
    };
    niri.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable niri as a window manager";
    };
    nordvpn.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable NordVPN with modifications to make it work";
    };
    ntfs.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable ntfs filesystem support";
    };
    paperless.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable Paperless-ngx document archive";
    };
    plasma.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable plasma as a window manaager";
    };
    postgres.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable the shared PostgreSQL server";
    };
    prowlarr.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable Prowlarr indexer manager";
    };
    qbittorrent = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "enable qBittorrent confined to a Proton VPN tunnel";
      };
      wireguardConfigFile = lib.mkOption {
        type = lib.types.str;
        default = "/etc/wireguard/proton.conf";
        description = "Proton VPN wireguard config the torrent client is confined to";
      };
    };
    radarr.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable Radarr movie manager";
    };
    readeck.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable Readeck read-it-later";
    };
    restic = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "enable restic backups";
      };
      localRepository = lib.mkOption {
        type = lib.types.str;
        default = "/mnt/backup/restic";
        description = "restic repository on the local backup drive";
      };
      offsiteRepository = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "offsite restic repository, credentials go in the secrets file";
      };
    };
    searxng.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable SearXNG metasearch";
    };
    seerr.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable Seerr media requests";
    };
    sonarr.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable Sonarr tv manager";
    };
    ssh.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable ssh hosting";
    };
    sync.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable sync packages between systems";
    };
    tailscale = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "enable tailscale";
      };
      advertiseRoutes = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        example = [ "192.168.0.0/24" ];
        description = "lan subnets this machine routes into the tailnet, each must be approved in the tailscale admin console";
      };
    };
    valkey.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable the shared Valkey cache";
    };
    vr.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable ALVR";
    };
    vm = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "enable libvirt/qemu for running a windows vm";
      };
      usbVendors = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ "1b1c" ];
        description = "usb vendor ids that vm-usb-passthrough attaches to a vm";
      };
    };
    wayvnc.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable wayvnc to share the hyprland desktop over vnc";
    };
    wivrn.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable WiVRn";
    };
    x.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable X";
    };
  };

  imports = [
    ../services/adguard.nix
    ../services/audiobookshelf.nix
    ../services/bazarr.nix
    ../services/bluetooth.nix
    ../services/caddy.nix
    ../services/dlna.nix
    ../services/docker.nix
    ../services/forgejo.nix
    ../services/homeassistant.nix
    ../services/hyprland.nix
    ../services/i3.nix
    ../services/immich.nix
    ../services/jellyfin.nix
    ../services/media.nix
    ../services/miniflux.nix
    ../services/musicassistant.nix
    ../services/navidrome.nix
    ../services/niri.nix
    ../services/nordvpn.nix
    ../services/ntfs.nix
    ../services/paperless.nix
    ../services/plasma.nix
    ../services/postgres.nix
    ../services/prowlarr.nix
    ../services/qbittorrent.nix
    ../services/radarr.nix
    ../services/readeck.nix
    ../services/restic.nix
    ../services/searxng.nix
    ../services/seerr.nix
    ../services/sonarr.nix
    ../services/ssh.nix
    ../services/sync.nix
    ../services/tailscale.nix
    ../services/valkey.nix
    ../services/vm.nix
    ../services/wayvnc.nix
    ../services/wivrn.nix
    ../services/x.nix
  ];
}
