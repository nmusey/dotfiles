{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.modules.core.audio.enable {
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber = {
        enable = true;
        package = pkgs.wireplumber;
      };
    };

    environment.systemPackages = with pkgs; [
      alsa-utils
      playerctl
      pavucontrol
    ];
  };
}
