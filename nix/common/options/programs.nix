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
      description = "enable zsh";
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
