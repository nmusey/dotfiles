{ config, lib, ... }:
{
    options = {
        bluetooth.enable = lib.mkEnableOption "enable bluetooth server";
    };

    config = {
        hardware.bluetooth.enable = true; 
        hardware.bluetooth.powerOnBoot = true;
        services.blueman.enable = true;
    };
}
