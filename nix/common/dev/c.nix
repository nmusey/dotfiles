{ config, pkgs, lib, ...}:
{
    options = {
        c.enable = lib.mkEnableOption "Enable C/C++ tooling, might be necessary for other modules becuase this installs compilers."
    };

    config = lib.mkIf config.c.enable {
        environment.systemPackages = with pkgs; [
            gcc
            cc
            clang
        ];
    };
}
