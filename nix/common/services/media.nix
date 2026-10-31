{ config, lib, ... }:
let
  cfg = config.modules.services;
  owner = config.variables.global.username;
in
{
  config = lib.mkIf cfg.media.enable {
    users.groups.media = { };
    users.users.${owner}.extraGroups = [ "media" ];

    systemd.tmpfiles.rules = map (dir: "d ${dir} 2775 ${owner} media -") [
      cfg.media.dir
      "${cfg.media.dir}/downloads"
      "${cfg.media.dir}/movies"
      "${cfg.media.dir}/tv"
      "${cfg.media.dir}/music"
      "${cfg.media.dir}/audiobooks"
      "${cfg.media.dir}/podcasts"
    ];
  };
}
