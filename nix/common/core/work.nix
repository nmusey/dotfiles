{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.modules.core.work.enable {
    networking.hosts = {
      "127.0.0.1" = [ "katipult.test" ];
    };

    users.users.${config.variables.global.username} = {
      packages = with pkgs; [
        php
        nginx
        phpPackages.composer
      ];

    };
  };
}
