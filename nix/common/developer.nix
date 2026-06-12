{ config, pkgs, lib, ... }:
{
    options = {
        developer.enable = lib.mkEnableOption "enable developer packages";
    };

    config = lib.mkIf config.developer.enable {
        environment.systemPackages = with pkgs; [
            ripgrep
            fzf
            tmux
            stow
            wget
            curl
            openssh
            jq
            bat
            lsof
            killall
            lazygit
        ];

        fonts.packages = with pkgs; [ 
            nerd-fonts.hasklug
        ];
    };
}
