{ config, pkgs, lib, ... }: 
{
    options = { 
        plasma.enable = lib.mkEnableOption "Enable plasma as a window manaager";
    };

    config = lib.mkIf config.plasma.enable {
        services.desktopManager.plasma6.enable = true;
    };
}
