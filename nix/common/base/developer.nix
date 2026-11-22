{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.modules.base.developer.enable {
    environment.systemPackages = with pkgs; [
      ripgrep
      fzf
      bat
      fd
      eza
      (btop.override { cudaSupport = config.modules.base.nvidia.enable; })
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
