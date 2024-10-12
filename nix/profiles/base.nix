{ config, pkgs, lib, ... }:
{
  users.users.${config.username}.packages = with pkgs; [
    git
    zsh
    vim
    gcc
    htop
  ];
}
