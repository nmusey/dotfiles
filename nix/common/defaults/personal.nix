{ config, lib, ... }:
{
    config = lib.mkIf config.presets.personal {
        modules.base.ai.enable = lib.mkDefault true;
        modules.base.localai.enable = lib.mkDefault true;
        modules.base.audio.enable = lib.mkDefault true;
        modules.base.developer.enable = lib.mkDefault true;
        modules.base.gaming.enable = lib.mkDefault true;
        modules.base.networking.enable = lib.mkDefault true;
        modules.base.settings.enable = lib.mkDefault true;
        modules.base.user.enable = lib.mkDefault true;
        modules.base.zsa.enable = lib.mkDefault true;

        modules.dev.c.enable = lib.mkDefault true;
        modules.dev.dotnet.enable = lib.mkDefault true;
        modules.dev.go.enable = lib.mkDefault true;
        modules.dev.godot.enable = lib.mkDefault true;
        modules.dev.javascript.enable = lib.mkDefault true;
        modules.dev.lua.enable = lib.mkDefault true;
        modules.dev.nix.enable = lib.mkDefault true;
        modules.dev.php.enable = lib.mkDefault true;
        modules.dev.rust.enable = lib.mkDefault true;
        modules.dev.unity.enable = lib.mkDefault true;
        modules.dev.zig.enable = lib.mkDefault true;

        modules.programs.desktop.enable = lib.mkDefault true;
        modules.programs.git.enable = lib.mkDefault true;
        modules.programs.neovim.enable = lib.mkDefault true;
        modules.programs.openrgb.enable = lib.mkDefault true;
        modules.programs.proton.enable = lib.mkDefault true;
        modules.programs.quickshell.enable = lib.mkDefault true;
        modules.programs.zathura.enable = lib.mkDefault true;
        modules.programs.zsh.enable = lib.mkDefault true;

        modules.services.bluetooth.enable = lib.mkDefault true;
        modules.services.dlna.enable = lib.mkDefault false;
        modules.services.docker.enable = lib.mkDefault true;
        modules.services.hyprland.enable = lib.mkDefault true;
        modules.services.plasma.enable = lib.mkDefault true;
        modules.services.niri.enable = lib.mkDefault false;
        modules.services.nordvpn.enable = lib.mkDefault true;
        modules.services.ntfs.enable = lib.mkDefault true;
        modules.services.ssh.enable = lib.mkDefault true;
        modules.services.sync.enable = lib.mkDefault true;
        modules.services.tailscale.enable = lib.mkDefault true;
        modules.services.wayvnc.enable = lib.mkDefault true;
        modules.services.wivrn.enable = lib.mkDefault false;
        modules.services.vr.enable = lib.mkDefault false;
        modules.services.vm.enable = lib.mkDefault true;
    };
}
