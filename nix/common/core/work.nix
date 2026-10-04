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

    modules.dev.php.enable = true;

    users.users.${config.variables.global.username} = {
      packages = with pkgs; [
        nginx
      ];

    };
  };
}
