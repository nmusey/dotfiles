{ ... }:
{
    programs.nix-ld.enable = true;
    nixpkgs.config.allowUnfree = true;
    environment.variables = {
        NIXPKGS_ALLOW_UNFREE = 1;
    };
  
    system.stateVersion = "unstable";
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
