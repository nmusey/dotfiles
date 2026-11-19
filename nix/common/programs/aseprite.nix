{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.modules.programs.aseprite.enable {
    environment.systemPackages = with pkgs; [
        aseprite
    ];
  };
}
