{ config, pkgs, lib, ... }:
{
  options = {
    katipult.enable = lib.mkEnableOption "enables packages for katipult development";
  };

  config = lib.mkIf config.katipult.enable {
    networking.hosts = {
      "127.0.0.1" = [ "katipult.test" ];
    };

    users.users.${config.username} = {
      packages = with pkgs; [
        kitty
        firefox
        nerdfonts
        unzip
        php
        intelephense
        neovim

        php
        nginx
        phpPackages.composer
      ];

    };
  };
}
