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
    variables.global.username = "USERNAME";

    # Enable preset if desired. Eg:
    # config.presets.personal.enable = true;

    environment.sessionVariables = {
      # HOST_SPECIFIC = "value";
    };

    # Overwrite options or modules. Eg:
    # modules.core.nvidia.enable = true;
  };
}
