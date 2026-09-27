{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.modules.programs.zsh.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
    };

    users.defaultUserShell = pkgs.zsh;
    environment.shells = with pkgs; [ zsh ];
  };
}
