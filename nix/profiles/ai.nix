{ config, pkgs, lib, ... }:
{
  options = {
    ai.enable = lib.mkEnableOption "enable AI tools";
  };

  config = lib.mkIf config.ai.enable {
    users.users.${config.username} = {
      packages = with pkgs; [
        ollama
        mods
        espeak
        piper-tts
      ];
    };

    services.ollama = {
      enable = true;
      acceleration = "cuda";
    };
  };
}
