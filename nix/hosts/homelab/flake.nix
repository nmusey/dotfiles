{
  description = "Flake for my homelab (Raspberry Pi 4)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    vpn-confinement.url = "github:Maroka-chan/VPN-Confinement";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      vpn-confinement,
      ...
    }@inputs:
    {
      nixosConfigurations.homelab = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          nixos-hardware.nixosModules.raspberry-pi-4
          vpn-confinement.nixosModules.default
          ./configuration.nix
        ];
      };
    };
}
