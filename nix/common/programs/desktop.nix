{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    desktop.enable = lib.mkEnableOption "Enable various desktop applications";
  };

  config = lib.mkIf config.desktop.enable {
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
      openrgb
      vscode
      libreoffice-qt
      qbittorrent
    ];
  };
}
