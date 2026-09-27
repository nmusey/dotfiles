{
  pkgs,
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.modules.services.docker.enable {
    users.users.${config.variables.global.username}.extraGroups = [ "docker" ];

    virtualisation.docker = {
      enable = true;
      rootless = {
        enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      docker
      docker-compose
    ];
  };
}
