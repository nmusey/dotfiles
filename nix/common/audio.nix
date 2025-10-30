{ config, pkgs, lib, ... }:
{
  options = {
    audio.enable = lib.mkEnableOption "enable audio";
  };

  config = lib.mkIf config.audio.enable {
    security.rtkit.enable = true;

    services.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    systemPackages = with pkgs; [
        alsa-utils
        playerctl
    ];
  };
}
