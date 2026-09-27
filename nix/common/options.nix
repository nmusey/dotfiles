{ lib, ... }:
{
  options = {
    variables.global.username = lib.mkOption {
      type = lib.types.str;
      default = "nick";
      description = "username for this device";
    };
  };

  imports = [
    ./options/core.nix
    ./options/dev.nix
    ./options/programs.nix
    ./options/services.nix
  ];
}
