{ pkgs, config, lib, ... }:
{
    options = {
        zsa.enable = lib.mkEnableOption "Enable ZSA keyboard support";
    };

    config = lib.mkIf config.zsa.enable {
        hardware.keyboard.zsa.enable = true;

        environment.systemPackages = with pkgs; [
            wally-cli
            keymapp
        ];
    };
}
