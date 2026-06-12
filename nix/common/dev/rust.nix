{ config, lib, pkgs, ...}:
{
    options = {
        rust.enable = lib.mkEnableOption "enable Rust programming environment";
    };

    config = lib.mkIf config.rust.enable {
        environment.systemPackages = with pkgs; [
            cargo
            rust-analyzer
            rustfmt
            rustup
        ];
    };
}
