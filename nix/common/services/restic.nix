{ config, lib, ... }:
let
  cfg = config.modules.services;
  backup = {
    initialize = true;
    environmentFile = config.variables.global.secretsFile;
    paths = [
      "/var/lib"
      "/var/backup"
      "/srv/Documents"
    ];
    exclude = [
      "/var/lib/postgresql"
      "/var/lib/redis-*"
      "/var/lib/docker"
      "/var/lib/immich/thumbs"
      "/var/lib/immich/encoded-video"
      "/var/lib/jellyfin/transcodes"
      "/var/lib/systemd"
      "**/cache"
    ];
    pruneOpts = [
      "--keep-daily 7"
      "--keep-weekly 5"
      "--keep-monthly 12"
    ];
  };
in
{
  config = lib.mkIf cfg.restic.enable {
    services.restic.backups = {
      local = backup // {
        repository = cfg.restic.localRepository;
        paths = backup.paths ++ map (dir: "${cfg.media.dir}/${dir}") [
          "music"
          "audiobooks"
          "podcasts"
        ];
        timerConfig = {
          OnCalendar = "03:00";
          Persistent = true;
        };
      };
      offsite = lib.mkIf (cfg.restic.offsiteRepository != null) (
        backup
        // {
          repository = cfg.restic.offsiteRepository;
          timerConfig = {
            OnCalendar = "04:30";
            Persistent = true;
            RandomizedDelaySec = "30m";
          };
        }
      );
    };

    systemd.services.restic-backups-local.unitConfig.RequiresMountsFor = [ cfg.restic.localRepository ];
  };
}
