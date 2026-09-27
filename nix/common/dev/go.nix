{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.modules.dev.go.enable {
    environment.systemPackages = with pkgs; [
      go
      delve
      protobuf
      protoc-gen-go
      templ
      gnumake
    ];
  };
}
