{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.modules.services.plasma.enable {
    services.desktopManager.plasma6.enable = true;
  };
}
