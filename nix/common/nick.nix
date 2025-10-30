{ config, lib, pkgs, ... }:
{
    options = {
        nick.enable = lib.mkEnableOption "enable Nick's custom environment";
    };

    config = lib.mkIf config.nick.enable {
        user.users.nick = {
            isNormalUser = true;
            shell = pkgs.zsh;
            extraGroups = [ "wheel" "networkmanager" "docker" ];

            packages = with pkgs; [
                firefox
                brave
                spotify
                obsidian
                flameshot
                zathura
                rsync
                steam-run
                obs-studio
                discord
                anki-bin
                zoom-us
                vlc
                cura-appimage
            ];
        };

        services.syncthing = {
            enable = true;
            openDefaultPorts = true;
            user = "nick";
        };

        services.flatpak.enable = true;
    };
}
