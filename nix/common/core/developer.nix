{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.modules.core.developer.enable {
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
      tealdeer
    ];

    fonts.packages = with pkgs; [
      nerd-fonts.hasklug
    ];
  };
}
