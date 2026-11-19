{ config, lib, ... }:
{
    config = lib.mkIf config.presets.server {
        modules.base.ai.enable = lib.mkDefault false;
        modules.base.localai.enable = lib.mkDefault false;
        modules.base.audio.enable = lib.mkDefault false;
        modules.base.developer.enable = lib.mkDefault true;
        modules.base.gaming.enable = lib.mkDefault false;
        modules.base.networking.enable = lib.mkDefault true;
        modules.base.settings.enable = lib.mkDefault true;
        modules.base.user.enable = lib.mkDefault true;
        modules.base.zsa.enable = lib.mkDefault false;

        modules.dev.c.enable = lib.mkDefault true;
        modules.dev.go.enable = lib.mkDefault true;
        modules.dev.godot.enable = lib.mkDefault true;
        modules.dev.javascript.enable = lib.mkDefault true;
        modules.dev.lua.enable = lib.mkDefault true;
        modules.dev.nix.enable = lib.mkDefault true;
        modules.dev.php.enable = lib.mkDefault true;
        modules.dev.rust.enable = lib.mkDefault true;
        modules.dev.unity.enable = lib.mkDefault true;
        modules.dev.zig.enable = lib.mkDefault true;

        modules.programs.desktop.enable = lib.mkDefault false;
        modules.programs.git.enable = lib.mkDefault true;
        modules.programs.neovim.enable = lib.mkDefault true;
        modules.programs.openrgb.enable = lib.mkDefault false;
        modules.programs.proton.enable = lib.mkDefault false;
        modules.programs.quickshell.enable = lib.mkDefault false;
        modules.programs.zathura.enable = lib.mkDefault false;
        modules.programs.zsh.enable = lib.mkDefault true;

        modules.services.bluetooth.enable = lib.mkDefault false;
        modules.services.dlna.enable = lib.mkDefault false;
        modules.services.docker.enable = lib.mkDefault true;
        modules.services.hyprland.enable = lib.mkDefault false;
        modules.services.plasma.enable = lib.mkDefault false;
        modules.services.niri.enable = lib.mkDefault false;
        modules.services.nordvpn.enable = lib.mkDefault false;
        modules.services.ntfs.enable = lib.mkDefault false;
        modules.services.ssh.enable = lib.mkDefault true;
        modules.services.sync.enable = lib.mkDefault true;
        modules.services.tailscale.enable = lib.mkDefault false;
        modules.services.wayvnc.enable = lib.mkDefault false;
        modules.services.wivrn.enable = lib.mkDefault false;
        modules.services.vr.enable = lib.mkDefault false;
    };
}
