{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.modules.core.gaming.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };

    programs.gamemode.enable = true;

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    boot.kernelModules = [ "ntsync" ];
    services.udev.extraRules = ''
      KERNEL=="ntsync", MODE="0660", TAG+="uaccess"
    '';

    environment.sessionVariables = {
      PROTONPATH = "GE-Proton";
    };

    environment.systemPackages = with pkgs; [
      lutris
      prismlauncher
      wineWow64Packages.stagingFull
      winetricks
      vulkan-tools
      umu-launcher
    ];
  };
}
