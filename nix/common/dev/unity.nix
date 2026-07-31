{
    config,
    lib,
    pkgs,
    ...
}:
{
    options = {
        unity.enable = lib.mkEnableOption "enable Unity game engine";
    };

    config = lib.mkIf config.unity.enable {
        environment.systemPackages = with pkgs; [
            unityhub
            roslyn-ls
        ];
    };
}
