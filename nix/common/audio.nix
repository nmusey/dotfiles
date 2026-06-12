{ config, pkgs, lib, ... }:
{
  options = {
    audio.enable = lib.mkEnableOption "enable audio";
  };

  config = lib.mkIf config.audio.enable {
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
