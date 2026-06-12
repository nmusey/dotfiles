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
                vim
                flameshot
                zathura
                rsync
                kitty
                imagemagick
                wl-clipboard
                unzip
                yazi
                hunspell
                hunspellDicts.en_US
                waypipe
            ];
        };

        xdg.portal.enable = true;
        services.flatpak.enable = true;
    };
}
