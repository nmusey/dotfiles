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
    modules.base.nvidia.enable = true;

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

    fileSystems."/hdd" = {
      device = "/dev/disk/by-uuid/C026837926836F6A";
      fsType = "ntfs3";
      options = [ "nofail" "uid=1000" "gid=100" "umask=022" ];
    };

    fileSystems."/ssd" = {
      device = "/dev/disk/by-uuid/880CA3F60CA3DE06";
      fsType = "ntfs3";
      options = [ "nofail" "uid=1000" "gid=100" "umask=022" ];
    };
  };
}
