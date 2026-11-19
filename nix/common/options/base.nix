{ lib, ... }:
{
  options.modules.base = {
    ai.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable AI tools";
    };
    localai.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable local AI models (ollama, open-webui)";
    };
    boot.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable systemd-boot with a plymouth splash";
    };
    audio.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable audio";
    };
    developer.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable miscellaneous cli/developer packages";
    };
    documentation.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "enable better documentation programs";
    };
    gaming.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enables gaming packages";
    };
    networking.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable networking";
    };
    nvidia.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable NVidia drivers";
    };
    settings.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable some miscellaneous NixOS settings";
    };
    user.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable admin user defaults custom environment";
    };
    work.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "LEGACY: enables packages for developing at Katipult";
    };
    zsa.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable ZSA keyboard support";
    };
  };

  imports = [
    ../base/ai.nix
    ../base/audio.nix
    ../base/boot.nix
    ../base/developer.nix
    ../base/gaming.nix
    ../base/localai.nix
    ../base/networking.nix
    ../base/nvidia.nix
    ../base/settings.nix
    ../base/user.nix
    ../base/work.nix
    ../base/zsa.nix
  ];
}
