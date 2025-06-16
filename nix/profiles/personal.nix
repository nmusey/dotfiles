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

   virtualisation.virtualbox.host.enable = true;
   virtualisation.virtualbox.host.enableExtensionPack = true;

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
        rsync
        steam-run
        obs-studio
        discord
        google-chrome
        brave
        qemu        
        playerctl
        anki-bin
        zoom-us
        alsa-utils
        yazi
        zoxide
        imagemagick
        bat
        eza
        neofetch
        vlc
        freecad-wayland
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
