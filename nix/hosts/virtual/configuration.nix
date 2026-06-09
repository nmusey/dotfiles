{ config, ... }:
{
  imports = [
     ../../common/include.nix
  ];

    config = {
        networking.hostName = "virtual";

        ai.enable = false;
        audio.enable = true;
        developer.enable = true;
        gaming.enable = false;
        networking.enable = true;
        nvidia.enable = false;
        settings.enable = true;
        user.enable = true;
        zsa.enable = false;
        
        desktop.enable = false;
        git.enable = true;
        neovim.enable = true;
        zsh.enable = true;

        dotnet.enable = false;
        go.enable = true;
        javascript.enable = true;
        lua.enable = true;
        rust.enable = true;

        bluetooth.enable = true;
        docker.enable = true;
        hyprland.enable = true;
        niri.enable = false;
        ssh.enable = true;
    };
}
