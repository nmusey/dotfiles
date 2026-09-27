{ lib, ... }:
{
  options.modules.core = {
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
    ../core/ai.nix
    ../core/audio.nix
    ../core/boot.nix
    ../core/developer.nix
    ../core/gaming.nix
    ../core/localai.nix
    ../core/networking.nix
    ../core/nvidia.nix
    ../core/settings.nix
    ../core/user.nix
    ../core/work.nix
    ../core/zsa.nix
  ];
}
