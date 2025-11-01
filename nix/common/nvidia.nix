{ config, lib, pkgs, ... }:
{
    options.nvidia.enable = lib.mkEnableOption "Enable NVidia drivers";

    config = lib.mkIf config.nvidia.enable {
        services.xserver.videoDrivers = [ "nvidia" ];

        hardware.graphics.enable = true;
        hardware.nvidia = {
            modesetting.enable = true;
            open = false;
            nvidiaSettings = true;
            forceFullCompositionPipeline = true;
        };

        environment.systemPackages = with pkgs; [
            pciutils
        ];
    };
}
