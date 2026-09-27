{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.modules.core.ai.enable {
    environment.systemPackages = [
      inputs.claude-code.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
