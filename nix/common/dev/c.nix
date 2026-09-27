{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.modules.dev.c.enable {
    environment.systemPackages = with pkgs; [
      gcc
      clang
    ];
  };
}
