{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.modules.dev.lua.enable {
    environment.systemPackages = with pkgs; [
      lua
      luaPackages.luarocks
    ];
  };
}
