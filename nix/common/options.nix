{ lib, ... }:
{
  options = {
    variables.global.username = lib.mkOption {
      type = lib.types.str;
      default = "nick";
      description = "username for this device";
    };

    variables.system.hostname = lib.mkOption {
        type = lib.types.str;
        default = "nixos";
        description = "hostname for this device";
    };
  };

  imports = [
    ./options/core.nix
    ./options/dev.nix
    ./options/programs.nix
    ./options/services.nix
    ./defaults/imports.nix
  ];

  config = {
      system.stateVersion = "26.05";
  };
}
