{ config, pkgs, lib, ... }:
{
    options = {
        vr.enable = lib.mkEnableOption "Enable ALVR";
    };

    config = {
        nixpkgs.config = {
            allowUnfree = true;
            cudaSupport = true;
        };


        networking.firewall.allowedUDPPorts = [ 9943 9944 ];

        services.xserver.videoDrivers = [ "nvidia" ];

        programs.alvr = {
            enable = true;
            openFirewall = true;
            package = pkgs.alvr;
        };

        programs.steam = {
            enable = true;
            remotePlay.openFirewall = true;
            dedicatedServer.openFirewall = true;
        };

        hardware.nvidia = {
            modesetting.enable = true;
            powerManagement.enable = true;
            open = false;
            nvidiaSettings = true;
            # package = config.boot.kernelPackages.nvidiaPackages.stable;
        };

        xdg.portal = {
            enable           = true;
            xdgOpenUsePortal = true;
        };

        services.udev.packages = [
            (pkgs.writeTextFile {
                name = "50-oculus.rules";
                destination = "/etc/udev/rules.d/50-oculus.rules";
                text = ''SUBSYSTEM=="usb", ATTR{idVendor}=="2833", ATTR{idProduct}=="0021", MODE="0666", OWNER="nick"'';
            })
            pkgs.android-udev-rules
        ];

        environment.systemPackages = with pkgs; [
            android-tools
            vulkan-tools
            vulkan-loader
            xdg-utils
            glxinfo
            pciutils
            cudatoolkit
        ];
    };
}
