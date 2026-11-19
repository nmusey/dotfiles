{ config, lib, ... }:
{
  config = lib.mkIf config.modules.services.musicassistant.enable {
    services.music-assistant = {
      enable = true;
      openFirewall = true;
      providers = [
        "airplay"
        "chromecast"
        "dlna"
        "filesystem_local"
        "hass"
        "hass_players"
        "jellyfin"
        "opensubsonic"
        "radiobrowser"
        "snapcast"
        "sonos"
        "spotify"
        "tidal"
        "ytmusic"
      ];
    };
    networking.firewall.allowedTCPPorts = [ 8095 8097 ];

    modules.services.caddy.hosts.speakers.port = 8095;
  };
}
