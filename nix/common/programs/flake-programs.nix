{ config, lib, pkgs, inputs, ... }:
{
    options = {
        flake-programs.enable = lib.mkEnableOption "Programs to enable once flakes are setup";
    };

    config = lib.mkIf config.flake-programs.enable {
        environment.systemPackages = with pkgs; [
            inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
            inputs.nordvpn-flake.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];
    };
}
