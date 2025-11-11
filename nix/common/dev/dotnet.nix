{ config, lib, pkgs, ... }:
{
    options = {
        dotnet.enable = lib.mkEnableOption "enable Dotnet programming environment";
    };

    config = lib.mkIf config.dotnet.enable {
        environment.systemPackages = with pkgs; [
            dotnet-sdk_9
            dotnet-ef
            roslyn-ls
        ];
    };
}
