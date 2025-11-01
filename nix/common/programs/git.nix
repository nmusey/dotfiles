{ config, pkgs, lib, ... }:
{
    options = {
        git.enable = lib.mkEnableOption "enable git";
    };

    config.programs.git = lib.mkIf config.git.enable {
        enable = true;
        config.user.name = "nmusey";
        config.user.email = "nmusey@gmail.com";
        config.init.defaultBranch = "main";
    };
}
