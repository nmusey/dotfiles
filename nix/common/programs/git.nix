{
  config,
  pkgs,
  lib,
  ...
}:
{
  config.programs.git = lib.mkIf config.modules.programs.git.enable {
    enable = true;
    config.user.name = "nmusey";
    config.user.email = "nmusey@gmail.com";
    config.init.defaultBranch = "main";
  };
}
