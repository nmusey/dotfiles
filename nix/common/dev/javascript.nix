{
  pkgs,
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.modules.dev.javascript.enable {
    environment.systemPackages = with pkgs; [
      nodejs
      yarn
      typescript
      npm-check-updates
    ];
  };
}
