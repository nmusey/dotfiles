{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.modules.dev.zig.enable {
    environment.systemPackages = with pkgs; [
        zig
    ];
  };
}
