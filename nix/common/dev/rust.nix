{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.modules.dev.rust.enable {
    environment.systemPackages = with pkgs; [
      cargo
      rust-analyzer
      rustfmt
      rustup
    ];
  };
}
