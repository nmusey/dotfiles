{ config, pkgs, lib, ... }:
let
  devpkgs = with pkgs; [
    go
    nodejs
    rustup
    dotnet-sdk_8
    protobuf
    protoc-gen-go
    cmake
    unityhub
  ];

  devtoolpkgs = with pkgs; [
    ripgrep
    fzf
    tmux
    stow
    wget
    curl
    openssh
    gnumake
    docker
    docker-compose
    jq
    neovim
    jetbrains-toolbox
    vscode
    bat
  ];
in
{
  options = {
    developer.enable = lib.mkEnableOption "enables developer packages";
  };


  config = lib.mkIf config.developer.enable {
    users.users.${config.username} = {
      packages = devpkgs ++ devtoolpkgs;
    };

    virtualisation.docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

    services.udev.packages = [
      pkgs.platformio-core
      pkgs.openocd
    ];

    programs.neovim.enable = true;
  };
}
