{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    developer.enable = lib.mkEnableOption "enable developer packages";
  };

  config = lib.mkIf config.developer.enable {
    environment.systemPackages = with pkgs; [
      ripgrep
      fzf
      bat
      fd
      eza
      btop
      htop
      tmux
      stow
      wget
      curl
      openssh
      jq
      lsof
      killall
      lazygit
      claude-code
    ];

    fonts.packages = with pkgs; [
      nerd-fonts.hasklug
    ];
  };
}
