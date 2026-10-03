{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../../common/options.nix
  ];

  config = {
    networking.hostName = "tower";
    variables.global.username = "nick";

    presets.personal = true; 
    modules.core.nvidia.enable = true;
    modules.services.personalnet = {
      enable = true;
      lanInterface = "enp38s0";
    };

    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
    environment.variables = {
      QT_QPA_PLATFORM = "wayland;xcb";
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

    boot.kernelModules = [
      "i2c-dev"
      "i2c-piix4"
    ];
  };
}
