{ lib, ... }:
{
  options.modules.programs = {
    desktop.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable various desktop applications";
    };
    git.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable git";
    };
    kanata.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Kanata keyboard remaps";
    };
    neovim.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable neovim";
    };
    openrgb.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable openrgb";
    };
    quickshell.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable quickshell desktop shell toolkit";
    };
    zsh.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable zsh";
    };
  };

  imports = [
    ../programs/desktop.nix
    ../programs/git.nix
    ../programs/kanata.nix
    ../programs/neovim.nix
    ../programs/openrgb.nix
    ../programs/quickshell.nix
    ../programs/zsh.nix
  ];
}
