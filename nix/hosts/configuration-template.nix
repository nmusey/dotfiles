{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../../common/include.nix
  ];

  config = {
    networking.hostName = "HOSTNAME";

    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "26.05";

    environment.sessionVariables = {
      # HOST_SPECIFIC = "value";
    };

    # Configure modules
    # eg developer.enable = true;
  };
}
