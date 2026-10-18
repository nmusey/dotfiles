{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.modules.programs.proton.enable {
    environment.systemPackages = with pkgs; [
      protonmail-desktop
      proton-pass
      proton-vpn
    ];
  };
}
