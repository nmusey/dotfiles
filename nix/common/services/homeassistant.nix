{
  config,
  lib,
  pkgs,
  ...
}:
let
  hass = config.services.home-assistant;
  proxy = {
    use_x_forwarded_for = true;
    trusted_proxies = [ "127.0.0.1/32" ];
  };
  defaultHttpStore = {
    version = 2;
    minor_version = 2;
    key = "http";
    data = {
      stable = {
        server_port = 8123;
        cors_allowed_origins = [ "https://cast.home-assistant.io" ];
        login_attempts_threshold = -1;
        ip_ban_enabled = true;
        ssl_profile = "modern";
        use_x_frame_options = true;
        error = null;
        error_message = null;
      };
      pending = null;
      yaml_migration_done = true;
    };
  };
in
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
        homekit = { };
        "automation ui" = "!include automations.yaml";
        "scene ui" = "!include scenes.yaml";
        "script ui" = "!include scripts.yaml";
      };
    };

    systemd.services.home-assistant.preStart = lib.mkAfter ''
      store=${hass.configDir}/.storage/http
      mkdir -p "$(dirname "$store")"
      [ -f "$store" ] || echo '${builtins.toJSON defaultHttpStore}' > "$store"
      ${lib.getExe pkgs.jq} --argjson proxy '${builtins.toJSON proxy}' '
        .data.stable += $proxy + {created_at: (.data.stable.created_at // (now | todate))}
        | if .data.pending then .data.pending += $proxy else . end
      ' "$store" > "$store.tmp"
      chmod 600 "$store.tmp"
      mv "$store.tmp" "$store"
    '';

    systemd.tmpfiles.rules = map (f: "f ${hass.configDir}/${f} 0644 hass hass -") [
      "automations.yaml"
      "scenes.yaml"
      "scripts.yaml"
    ];

    networking.firewall = {
      allowedTCPPorts = [ 8123 ];
      allowedTCPPortRanges = [
        {
          from = 21063;
          to = 21070;
        }
      ];
      allowedUDPPorts = [ 5353 ];
    };

    modules.services.caddy.hosts.ha.port = 8123;
  };
}
