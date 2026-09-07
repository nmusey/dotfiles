{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    user.enable = lib.mkEnableOption "enable Nick's custom environment";
  };

  config = lib.mkIf config.user.enable {
    users.users.nick = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
        "audio"
        "nordvpn"
        "video"
        "input"
      ];

      packages = with pkgs; [
        zathura
        imagemagick
        unzip
        yazi
        hunspell
        hunspellDicts.en_US
        localsend
        fastfetch
      ];
    };

    services.flatpak.enable = true;
  };
}
