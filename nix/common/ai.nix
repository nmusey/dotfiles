{ config, pkgs, lib, ... }:
{
    options = {
        ai.enable = lib.mkEnableOption "enable AI tools";
    };

    config = lib.mkIf config.ai.enable {
        environment.systemPackages = {
            packages = with pkgs; [
                ollama
                mods
                opencode
            ];
        };

        services.ollama = {
            enable = true;
            acceleration = "cuda";
        };
    };
}
