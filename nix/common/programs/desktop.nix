{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.modules.programs.desktop.enable {
    environment.systemPackages = with pkgs; [
      spotify
      obsidian
      obs-studio
      discord
      anki-bin
      zoom-us
      vlc
      cura-appimage
      calibre
      libreoffice-qt
      qbittorrent
      brave
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
