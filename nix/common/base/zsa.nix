{
  pkgs,
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.modules.base.zsa.enable {
    hardware.keyboard.zsa.enable = true;

    environment.systemPackages = with pkgs; [
      wally-cli
      keymapp
    ];
  };
}
