{
  description = "Flake for my personal desktop (tower)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    zen-browser.url = "github:youwen5/zen-browser-flake";
    nordvpn-flake.url = "github:nmusey/nordvpn-flake";
  };

  outputs = { self, nixpkgs, ... } @inputs: 
  {
    nixosConfigurations.tower = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
            ./hardware-configuration.nix
            ./configuration.nix
            inputs.nordvpn-flake.nixosModules.default
        ];
    };
  };
}
