{ config, lib, pkgs, ... }:
{
    options = {
        user.enable = lib.mkEnableOption "enable Nick's custom environment";
    };

    config = lib.mkIf config.user.enable {
        users.users.nick = {
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
                kitty
                hellwal
                pywal16
                imagemagick
                wl-clipboard
                unzip
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
