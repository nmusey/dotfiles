{ pkgs, lib, config, ...}:
{
    options = {
        go.enable = lib.mkEnableOption "enable Go programming environment";
    };

    config = lib.mkIf config.go.enable {
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
