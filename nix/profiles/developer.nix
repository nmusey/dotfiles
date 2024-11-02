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
    elixir
    lua
    lua54Packages.luarocks
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
    jetbrains-toolbox
    vscode
    bat
    lsof
  ];
in
{
  options = {
    developer.enable = lib.mkEnableOption "enables developer packages";
  };

  config = lib.mkIf config.developer.enable {
    environment.systemPackages = with pkgs; devpkgs ++ devtoolpkgs;

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
  };
}
