{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.modules.core.localai.enable {
    environment.systemPackages = with pkgs; [
      open-webui
    ];

    services.ollama = {
      enable = true;
    };
  };
}
