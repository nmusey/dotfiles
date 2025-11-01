{ pkgs, config, lib, ... }:
{
    options = {
        javascript.enable = lib.mkEnableOption "enable JavaScript/TypeScript programming environment";
    };

    config = lib.mkIf config.javascript.enable {
        environment.systemPackages = with pkgs; [
            nodejs
            yarn
            typescript
            eslint
            prettier
            ts-node
            nodemon
            npm-check-updates
        ];
    };
}
