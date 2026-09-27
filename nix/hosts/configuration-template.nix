{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../../common/options.nix
  ];

  config = {
    networking.hostName = "HOSTNAME";
    system.stateVersion = "26.05";

    environment.sessionVariables = {
      # HOST_SPECIFIC = "value";
    };

    # Configure modules
    # eg modules.core.developer.enable = true;
  };
}
