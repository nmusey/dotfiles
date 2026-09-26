{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    wivrn.enable = lib.mkEnableOption "Enable WiVRn";
  };

  config = lib.mkIf config.wivrn.enable {
    # Ensure config.nvidia.enable = true as well if using NVidia GPU

    services.wivrn = {
      enable = true;
      openFirewall = true;
      autoStart = true;
      highPriority = true;
      package = pkgs.wivrn;
      steam.importOXRRuntimes = true;
    };

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
    };

    services.udev.packages = with pkgs; [
      (writeTextFile {
        name = "50-oculus.rules";
        destination = "/etc/udev/rules.d/50-oculus.rules";
        text = ''SUBSYSTEM=="usb", ATTR{idVendor}=="2833", MODE="0666", OWNER="${config.variables.global.username}"'';
      })
    ];

    environment.variables = {
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      LIBVA_DRIVER_NAME = "nvidia";
    };

    environment.systemPackages = with pkgs; [
      android-tools
      vulkan-tools
      pciutils
    ];
  };
}
