{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    user.enable = lib.mkEnableOption "enable admin user defaults custom environment";
  };

  config = lib.mkIf config.user.enable {
    users.users.${config.variables.global.username} = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [
        "wheel"
        "networkmanager"
        "audio"
        "video"
        "input"
        "srv"
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

    systemd.tmpfiles.rules = [
        "d /srv 0755 ${config.variables.global.username} srv -"
    ];
  };
}
