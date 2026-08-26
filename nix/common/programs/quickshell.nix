{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    quickshell.enable = lib.mkEnableOption "Enable quickshell desktop shell toolkit";
  };

  config = lib.mkIf config.quickshell.enable {
    environment.systemPackages = with pkgs; [
      quickshell
    ];
  };
}
