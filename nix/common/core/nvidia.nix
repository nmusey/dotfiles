{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.modules.core.nvidia.enable {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;

      open = false;
      nvidiaSettings = true;
      forceFullCompositionPipeline = true;
    };

    environment.systemPackages = with pkgs; [
      pciutils
    ];
  };
}
