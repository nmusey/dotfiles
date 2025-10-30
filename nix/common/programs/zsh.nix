{ config, pkgs, lib, ... }:
{
    options.zsh.enable = lib.mkEnableOption "enable zsh";

    config = lib.mkIf config.zsh.enable {
        programs.zsh = {
            enable = true;
            enableCompletion = true;
        };

        users.defaultUserShell = pkgs.zsh;
        environment.shells = with pkgs; [ zsh ];
    };
}
