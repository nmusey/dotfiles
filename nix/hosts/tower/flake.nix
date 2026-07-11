{
  description = "Flake for my personal desktop (tower)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    zen-browser.url = "github:youwen5/zen-browser-flake";
    nordvpn-flake.url = "github:Triforcey/nordvpn-nix";
  };

  outputs =
    { self, nixpkgs, nordvpn-flake, ... }@inputs:
    {
      nixosConfigurations.tower = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hardware-configuration.nix
          nordvpn-flake.nixosModules.default
          ./configuration.nix
        ];
      };
    };
}
