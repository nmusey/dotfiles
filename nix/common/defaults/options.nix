{ lib, ... }:
{
    options = {
        variables.preset.personal = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "preset configuration for personal desktop or laptop computers";
        };

        variables.preset.server = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "preset configuration for servers";
        };
    };

    imports = [
        ./personal.nix
        ./server.nix
    ];
}
