{ config, ... }:
{
  imports = [
    ../../common/include.nix
  ];

    config = {
        networking.hostName = "tower";

        hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

        environment.sessionVariables = {
          WLR_NO_HARDWARE_CURSORS = "1";
          NIXOS_OZONE_WL = "1";
        };

        boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];
        environment.variables = {
          QT_QPA_PLATFORM = "wayland;xcb";
        };

        ai.enable = true;
        audio.enable = true;
        developer.enable = true;
        gaming.enable = true;
        networking.enable = true;
        nvidia.enable = true;
        settings.enable = true;
        user.enable = true;
        zsa.enable = true;

        javascript.enable = true;
        dotnet.enable = true;
        rust.enable = true;

        git.enable = true;
        neovim.enable = true;
        zsh.enable = true;

        bluetooth.enable = true;
        dlna.enable = false;
        docker.enable = true;
        niri.enable = true;
        ssh.enable = true;
    };
}
