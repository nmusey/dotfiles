{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../../common/include.nix
  ];

  config = {
    networking.hostName = "tower";

    nixpkgs.config.allowUnfree = true;
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

    system.stateVersion = "26.05";

    environment.systemPackages = with pkgs; [
      ntfs3g
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

    environment.variables = {
      QT_QPA_PLATFORM = "wayland;xcb";
    };

    boot.kernelModules = [
      "i2c-dev"
      "i2c-piix4"
    ];
    boot.supportedFilesystems = [ "ntfs" ];
    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

    ai.enable = true;
    audio.enable = true;
    developer.enable = true;
    desktop.enable = true;
    gaming.enable = true;
    networking.enable = true;
    nvidia.enable = true;
    settings.enable = true;
    user.enable = true;
    zsa.enable = true;

    c.enable = true;
    go.enable = true;
    godot.enable = true;
    javascript.enable = true;
    lua.enable = true;
    rust.enable = true;
    unity.enable = true;
    zig.enable = true;

    git.enable = true;
    neovim.enable = true;
    quickshell.enable = true;
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
