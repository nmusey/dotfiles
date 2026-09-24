{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options = {
    ai.enable = lib.mkEnableOption "enable AI tools";
  };

  config = lib.mkIf config.ai.enable {
    environment.systemPackages = with pkgs; [
      open-webui
      inputs.claude-code.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    services.ollama = {
      enable = true;
    };
  };
}
