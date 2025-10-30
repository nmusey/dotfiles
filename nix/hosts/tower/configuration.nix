{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../_module.nix
  ];

    config = {
        networking.hostName = "tower";
        hardware = {
            graphics.enable = true;
        };

        environment.sessionVariables = {
          WLR_NO_HARDWARE_CURSORS = "1";
          NIXOS_OZONE_WL = "1";
        };

        boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];
        environment.variables = {
          QT_QPA_PLATFORM = "wayland;xcb";
        };
    };
}
