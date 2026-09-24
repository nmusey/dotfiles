{
  pkgs,
  config,
  lib,
  ...
}:
{
  options = {
    docker.enable = lib.mkEnableOption "enable Docker and related tools";
  };

  config = lib.mkIf config.docker.enable {
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
