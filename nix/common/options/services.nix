{ lib, ... }:
{
  options.modules.services = {
    bluetooth.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable bluetooth server";
    };
    dlna.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable dlna streaming server";
    };
    docker.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable Docker and related tools";
    };
    hyprland.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable hyprland as window manager";
    };
    i3.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable i3 as a window manager";
    };
    niri.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable niri as a window manager";
    };
    nordvpn.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable NordVPN with modifications to make it work";
    };
    ntfs.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "enable ntfs filesystem support";
    };
    personalnet = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "share the wan connection to a personal network on the lan interface";
      };
      lanInterface = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "interface the personal network's access point is plugged into";
      };
    };
    plasma.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable plasma as a window manaager";
    };
    ssh.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable ssh hosting";
    };
    sync.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable sync packages between systems";
    };
    tailscale.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable tailscale";
    };
    vr.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable ALVR";
    };
    wivrn.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable WiVRn";
    };
    x.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable X";
    };
  };

  imports = [
    ../services/bluetooth.nix
    ../services/dlna.nix
    ../services/docker.nix
    ../services/hyprland.nix
    ../services/i3.nix
    ../services/niri.nix
    ../services/nordvpn.nix
    ../services/ntfs.nix
    ../services/personalnet.nix
    ../services/plasma.nix
    ../services/ssh.nix
    ../services/sync.nix
    ../services/tailscale.nix
    ../services/wivrn.nix
    ../services/x.nix
  ];
}
