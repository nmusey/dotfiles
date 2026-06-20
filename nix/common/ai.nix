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
      ollama-cuda
    ];
  };
}
