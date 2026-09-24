{
    config,
    lib,
    pkgs,
    ...
}:
{
    options = {
        variables.global.username = lib.mkOption {
          type = lib.types.str;
          default = "nick";
          description = "username for this device";
        };
    };
}
