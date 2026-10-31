{ lib, ... }:
{
  options.modules.programs = {
    aseprite.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable aseprite editor";
    };
    desktop.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable various desktop applications";
    };
    git.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable git";
    };
    kanata.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Kanata keyboard remaps";
    };
    neovim.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable neovim";
    };
    openrgb.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable openrgb";
    };
    proton.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable proton mail, pass, and vpn";
    };
    quickshell.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable quickshell desktop shell toolkit";
    };
    zathura.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable zathura as the default pdf and image viewer";
    };
    zsh.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable zsh";
    };
  };

  imports = [
    ../programs/desktop.nix
    ../programs/git.nix
    ../programs/kanata.nix
    ../programs/neovim.nix
    ../programs/openrgb.nix
    ../programs/proton.nix
    ../programs/quickshell.nix
    ../programs/zathura.nix
    ../programs/zsh.nix
  ];
}
