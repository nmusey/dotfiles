{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    zig.enable = lib.mkEnableOption "enable Zig compiler";
  };

  config = lib.mkIf config.zig.enable {
    environment.systemPackages = with pkgs; [
        zig
    ];
  };
}
