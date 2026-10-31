{ config, lib, ... }:
{
  config = lib.mkIf config.modules.services.homeassistant.enable {
    services.home-assistant = {
      enable = true;
      extraComponents = [
        "default_config"
        "esphome"
        "homekit"
        "homekit_controller"
        "isal"
        "met"
        "music_assistant"
        "radio_browser"
      ];
      config = {
        default_config = { };
        homeassistant = {
          name = "Home";
          unit_system = "metric";
          time_zone = config.time.timeZone;
        };
        http = {
          use_x_forwarded_for = true;
          trusted_proxies = [ "127.0.0.1" ];
        };
        homekit = { };
        "automation ui" = "!include automations.yaml";
        "scene ui" = "!include scenes.yaml";
        "script ui" = "!include scripts.yaml";
      };
    };

    systemd.tmpfiles.rules = map (f: "f ${config.services.home-assistant.configDir}/${f} 0644 hass hass -") [
      "automations.yaml"
      "scenes.yaml"
      "scripts.yaml"
    ];

    networking.firewall = {
      allowedTCPPorts = [ 21064 ];
      allowedUDPPorts = [ 5353 ];
    };

    modules.services.caddy.hosts.ha.port = 8123;
  };
}
