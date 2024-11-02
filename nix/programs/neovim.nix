{ config, lib, pkgs, ... }:
let
  nvim = pkgs.neovim.overrideAttrs
    (old: {
      version = "git";
      src = pkgs.fetchFromGitHub
        {
          owner = "neovim";
          repo = "neovim";
          rev = "v0.10.2";
          sha256 = "sha256-+qjjelYMB3MyjaESfCaGoeBURUzSVh/50uxUqStxIfY=";
        };
    });
in
{
  options = {
    neovim.enable = lib.mkEnableOption "enable neovim";
  };

  config = lib.mkIf config.neovim.enable
    {
      users.users.${config.username} =
        {
          packages = [ nvim ];
        };

      environment.systemPackages = [ nvim ];
    };
}
