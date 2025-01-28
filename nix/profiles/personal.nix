{ config, pkgs, lib, ... }:
{
  options = {
    personal.enable = lib.mkEnableOption "enables a personal user";
  };

  config = lib.mkIf config.personal.enable {
    programs.nix-ld.enable = true;
    environment.variables = {
      NIXPKGS_ALLOW_UNFREE = 1;
    };

    users.users.${config.username} = {
      isNormalUser = true;
      description = "Nick Musey";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      packages = with pkgs; [
        wally-cli
        kitty
        firefox
        unzip
        openrgb
        spotify
        obsidian
        flameshot
        zathura
        bitwarden-desktop
        bitwarden-cli
        rsync
        steam-run
        obs-studio
        discord
        google-chrome
        qemu        
        playerctl
        anki-bin
        zoom-us
      ];
    };

    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
      user = "nick";
    };
  };
}
