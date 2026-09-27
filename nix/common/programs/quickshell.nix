{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.modules.programs.quickshell.enable {
    environment.systemPackages = with pkgs; [
      quickshell
    ];
  };
}
