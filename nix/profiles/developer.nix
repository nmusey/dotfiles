{ config, pkgs, lib, ... }:
let
  devpkgs = with pkgs; [
    go
    delve
    protobuf
    protoc-gen-go
    templ
    nodejs
    cmake
    unityhub
    lua
    python3
    SDL2
    php84
    php84Packages.composer
    dotnetCorePackages.dotnet_8.sdk
    dotnet-ef
    cargo
    rustup
    maven
    jdk
    ruby
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
    zellij
    code-cursor
    windsurf
  ];
in
{
  options = {
    developer.enable = lib.mkEnableOption "enables developer packages";
  };

  config = lib.mkIf config.developer.enable {
    environment.systemPackages = devpkgs ++ devtoolpkgs;

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

    fonts.packages = with pkgs; [ 
      pkgs.nerd-fonts.hasklug
    ];
  };
}
