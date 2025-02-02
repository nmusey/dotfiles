{ config, pkgs, lib, ... }:
{
  options = {
    server.enable = lib.mkEnableOption "enables a server user";
  };

  config = lib.mkIf config.server.enable {
    users.users.${config.username} = {
      isNormalUser = true;
      description = "Web host user";
      packages = with pkgs; [
        neovim
        ripgrep
        tmux
      ];
    };
  };
}
