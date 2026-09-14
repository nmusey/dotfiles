{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    ai.enable = lib.mkEnableOption "enable AI tools";
  };

  config = lib.mkIf config.ai.enable {
    environment.systemPackages = with pkgs; [
      claude-code
      open-webui
    ];

    services.ollama = {
        enable = true;
    };
  };
}
