{ lib, ... }: 
{
    imports = [
        ./ai.nix
        ./base.nix
        ./developer.nix
        ./gaming.nix
        ./personal.nix
        ./server.nix
        ./work.nix
    ];

    developer.enable = lib.mkDefault true;
    gaming.enable = lib.mkDefault false;
    personal.enable = lib.mkDefault false;
    server.enable = lib.mkDefault false;
    katipult.enable = lib.mkDefault false;
}
