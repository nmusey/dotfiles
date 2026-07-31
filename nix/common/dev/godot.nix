{
    config,
    lib,
    pkgs,
    ...
}:
{
    options = {
        godot.enable = lib.mkEnableOption "enable Godot game engine";
    };

    config = lib.mkIf config.godot.enable {
        environment.systemPackages = with pkgs; [
            godot
        ];
    };
}
