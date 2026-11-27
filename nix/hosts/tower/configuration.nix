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
    services.tailscale.extraSetFlags = [ "--accept-routes" ];

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

    fileSystems."/data" = {
      device = "/dev/disk/by-uuid/e84257a9-d2f0-47c3-9f1f-79dbd375f147";
      fsType = "ext4";
      options = [ "nofail" ];
    };

    systemd.tmpfiles.rules = [
      "d /data 0755 ${config.variables.global.username} users -"
    ];

    fileSystems."/ssd" = {
      device = "/dev/disk/by-uuid/880CA3F60CA3DE06";
      fsType = "ntfs-3g";
      options = [ "nofail" "uid=1000" "gid=100" "umask=022" ];
    };
  };
}
