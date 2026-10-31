{ config, lib, ... }:
{
  config = lib.mkIf config.modules.services.postgres.enable {
    services.postgresql.enable = true;

    services.postgresqlBackup = {
      enable = true;
      backupAll = true;
    };
  };
}
