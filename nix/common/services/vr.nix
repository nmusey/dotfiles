{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    vr.enable = lib.mkEnableOption "Enable ALVR";
  };

  config = lib.mkIf config.vr.enable {
    # Unfree packages are required - ensure they are enabled.
    # Ensure config.nvidia.enable = true as well if using NVidia GPU

    programs.alvr = {
      enable = true;
      openFirewall = true;
      package = pkgs.alvr;
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
      android-udev-rules
    ];

    environment.variables = {
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      LIBVA_DRIVER_NAME = "nvidia";
    };

    environment.systemPackages = with pkgs; [
      android-tools
      vulkan-tools
      xdg-utils
      glxinfo
      pciutils
      cudatolkit
      zenit
    ];
  };
}
