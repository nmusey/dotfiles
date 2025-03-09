{ config, pkgs, lib, ... }:
{
  options = {
    audio.enable = lib.mkEnableOption "enable audio";
  };

  config = lib.mkIf config.audio.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
