{
  description = "Flake for my personal desktop (tower)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    zen-browser.url = "github:youwen5/zen-browser-flake";
    nordvpn-flake.url = "github:connerohnesorge/nordvpn-flake";
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
