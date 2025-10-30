{ pkgs, config, lib, ... }:
{
    options = {
        docker.enable = lib.mkEnableOption "enable Docker and related tools";
    };

    config = lib.mkIf config.docker.enable {
        virtualisation.docker = {
            enable = true;
            compose = {
                enable = true;
            };

            rootless = {
                enable = true;
                setSocketVariables = true;
            };
        };


        systemPackages = with pkgs; [
            docker
            docker-compose
        ];
    };
}
