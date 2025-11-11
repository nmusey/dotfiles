{ config, ... }:
{
  imports = [
     ../../common/include.nix
  ];

    config = {
        networking.hostName = "fool";

        hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
    
        ai.enable = true;
        audio.enable = true;
        developer.enable = true;
        gaming.enable = true;
        networking.enable = true;
        nvidia.enable = true;
        settings.enable = true;
        user.enable = true;
        
        git.enable = true;
        neovim.enable = true;
        zsh.enable = true;

        dotnet.enable = true;
        go.enable = true;
        javascript.enable = true;
        lua.enable = true;
        rust.enable = true;

        bluetooth.enable = true;
        docker.enable = true;
        niri.enable = true;
        ssh.enable = true;
    };
}
