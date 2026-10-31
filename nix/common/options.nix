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

    variables.global.sshKeys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICKmxw4WI7k418uf4nOfps7+CZK9nxG/bM245a4309mK nick@nixos"
      ];
      description = "public ssh keys authorized to log in as the user";
    };
  };

  imports = [
    ./options/base.nix
    ./options/dev.nix
    ./options/programs.nix
    ./options/services.nix
    ./defaults/options.nix
  ];

  config = {
      system.stateVersion = "26.05";
  };
}
