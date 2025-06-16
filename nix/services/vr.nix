{ config, pkgs, lib, ... }:
{
    options = {
        vr.enable = lib.mkEnableOption "Enable ALVR";
    };

    config = {
        nixpkgs.config = {
            allowUnfree = true;
        };

        networking.firewall.allowedUDPPorts = [ 9943 9944 ];

        hardware.nvidia = {
            modesetting.enable = true;
            powerManagement.enable = true;
            nvidiaSettings = true;
        };

        programs.alvr = {
            enable = true;
            openFirewall = true;
            package = pkgs.alvr;
        };

        programs.nix-ld.enable = true;

        programs.steam = {
            enable = true;
            remotePlay.openFirewall = true;
            dedicatedServer.openFirewall = true;
        };

        services.udev.packages = with pkgs; [
            (writeTextFile {
                name = "50-oculus.rules";
                destination = "/etc/udev/rules.d/50-oculus.rules";
                text = ''SUBSYSTEM=="usb", ATTR{idVendor}=="2833", ATTR{idProduct}=="0021", MODE="0666", OWNER="nick"'';
            })
            android-udev-rules
        ];

        services.xserver.videoDrivers = [ "nvidia" ];

        environment.variables = {
            __GLX_VENDOR_LIBRARY_NAME = "nvidia";
            LIBVA_DRIVER_NAME = "nvidia";
        };

        environment.systemPackages = with pkgs; [
            android-tools
            vulkan-tools
            vulkan-loader
            xdg-utils
            glxinfo
            pciutils
            cudatoolkit
            vulkan-validation-layers
            zenity
        ];

        xdg.portal = {
            enable           = true;
            xdgOpenUsePortal = true;
        };
    };
}
