{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.modules.dev.nix.enable {
    environment.systemPackages = with pkgs; [
      # formatting
      nixfmt
      nixfmt-tree

      # language servers
      nil
      nixd

      # linting
      statix
      deadnix

      # build/closure inspection
      nix-output-monitor
      nix-tree
      nix-diff
      nvd

      # fetcher hash generation
      nurl
    ];

    programs.nh.enable = true;

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
