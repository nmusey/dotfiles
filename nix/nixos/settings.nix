{ ... }:
{
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
