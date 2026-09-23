{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    user.enable = lib.mkEnableOption "enable desktop user defaults custom environment";
    variables.global.username = lib.mkOption {
      type = lib.types.str;
      default = "nick";
      description = "username for this device";
    };
  };

  config = lib.mkIf config.user.enable {
    users.users.${config.variables.global.username} = {
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
        speedtest-cli
        (mpv.override { scripts = [ mpvScripts.mpris ]; })

      ];
    };

    services.flatpak.enable = true;
  };
}
