{ config, pkgs, ... }:
{
  imports = [
    ../../common/include.nix
    ../../common/programs/flake-programs.nix
  ];

  config = {
    networking.hostName = "tower";

    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

    system.stateVersion = "26.05";

    environment.systemPackages = [ pkgs.ntfs3g ];
    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

    environment.variables = {
      QT_QPA_PLATFORM = "wayland;xcb";
    };

    boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];
    boot.supportedFilesystems = [ "ntfs" ];

    flake-programs.enable = true;

    ai.enable = true;
    audio.enable = true;
    developer.enable = true;
    gaming.enable = true;
    networking.enable = true;
    nvidia.enable = true;
    settings.enable = true;
    user.enable = true;
    zsa.enable = true;

    go.enable = true;
    javascript.enable = true;
    lua.enable = true;
    rust.enable = true;

    git.enable = true;
    neovim.enable = true;
    zsh.enable = true;

    bluetooth.enable = true;
    dlna.enable = false;
    docker.enable = true;
    hyprland.enable = true;
    plasma.enable = true;
    niri.enable = false;
    ssh.enable = true;
  };
}
