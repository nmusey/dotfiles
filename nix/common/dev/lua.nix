{ config, lib, pkgs, ... }:
{
    options = {
        lua.enable = lib.mkEnableOption "enable Lua programming environment";
    };

    config = lib.mkIf config.lua.enable {
        environment.systemPackages = with pkgs; [
            lua
            luaPackages.luarocks
        ];
    };
}
