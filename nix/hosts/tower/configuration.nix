{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../../common/options.nix
  ];

  config = {
    networking.hostName = "tower";
    variables.global.username = "nick";

    system.stateVersion = "26.05";

    environment.systemPackages = with pkgs; [
      ntfs3g
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

    modules.core.ai.enable = true;
    modules.core.localai.enable = true;
    modules.core.audio.enable = true;
    modules.core.developer.enable = true;
    modules.programs.desktop.enable = true;
    modules.core.gaming.enable = true;
    modules.core.networking.enable = true;
    modules.core.nvidia.enable = true;
    modules.core.settings.enable = true;
    modules.core.user.enable = true;
    modules.core.zsa.enable = true;

    modules.dev.c.enable = true;
    modules.dev.go.enable = true;
    modules.dev.godot.enable = true;
    modules.dev.javascript.enable = true;
    modules.dev.lua.enable = true;
    modules.dev.rust.enable = true;
    modules.dev.unity.enable = true;
    modules.dev.zig.enable = true;

    modules.programs.git.enable = true;
    modules.programs.neovim.enable = true;
    modules.programs.openrgb.enable = true;
    modules.programs.quickshell.enable = true;
    modules.programs.zsh.enable = true;

    modules.services.bluetooth.enable = true;
    modules.services.dlna.enable = false;
    modules.services.docker.enable = true;
    modules.services.hyprland.enable = true;
    modules.services.plasma.enable = true;
    modules.services.niri.enable = false;
    modules.services.nordvpn.enable = true;
    modules.services.ssh.enable = true;
    modules.services.sync.enable = true;
    modules.services.tailscale.enable = true;
    modules.services.wivrn.enable = true;
  };
}
