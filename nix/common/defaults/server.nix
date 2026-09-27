{ lib, ... }:
{
    config = lib.mkIf config.presets.server {
        modules.core.ai.enable = false;
        modules.core.localai.enable = false;
        modules.core.audio.enable = false;
        modules.core.developer.enable = true;
        modules.core.gaming.enable = false;
        modules.core.networking.enable = true;
        modules.core.settings.enable = true;
        modules.core.user.enable = true;
        modules.core.zsa.enable = false;

        modules.dev.c.enable = true;
        modules.dev.go.enable = true;
        modules.dev.godot.enable = true;
        modules.dev.javascript.enable = true;
        modules.dev.lua.enable = true;
        modules.dev.nix.enable = true;
        modules.dev.rust.enable = true;
        modules.dev.unity.enable = true;
        modules.dev.zig.enable = true;

        modules.programs.desktop.enable = false;
        modules.programs.git.enable = true;
        modules.programs.neovim.enable = true;
        modules.programs.openrgb.enable = false;
        modules.programs.quickshell.enable = false;
        modules.programs.zsh.enable = true;

        modules.services.bluetooth.enable = false;
        modules.services.dlna.enable = false;
        modules.services.docker.enable = true;
        modules.services.hyprland.enable = false;
        modules.services.plasma.enable = false;
        modules.services.niri.enable = false;
        modules.services.nordvpn.enable = false;
        modules.services.ntfs.enable = false;
        modules.services.ssh.enable = true;
        modules.services.sync.enable = true;
        modules.services.tailscale.enable = false;
        modules.services.wivrn.enable = false;
        modules.services.vr.enable = false;
    };
}
