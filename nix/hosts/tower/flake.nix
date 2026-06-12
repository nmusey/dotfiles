{
  description = "Flake for my personal desktop (tower)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.tower = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
            ./hardware-configuration.nix
            ./configuration.nix
        ];
    };
  };
}
