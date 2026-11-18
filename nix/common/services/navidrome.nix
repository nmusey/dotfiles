{ config, lib, ... }:
let
  cfg = config.modules.services;
in
{
  config = lib.mkIf cfg.navidrome.enable {
    services.navidrome = {
      enable = true;
      settings = {
        Address = "127.0.0.1";
        Port = 4533;
        MusicFolder = "${cfg.media.dir}/music";
        Plugins.Enabled = false;
      };
    };
    users.users.navidrome.extraGroups = [ "media" ];
    modules.services.media.enable = true;

    modules.services.caddy.hosts.music.port = config.services.navidrome.settings.Port;
  };
}
