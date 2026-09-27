{
    config,
    lib,
    pkgs,
    ...
}:
{
    config = lib.mkIf config.modules.dev.godot.enable {
        environment.systemPackages = with pkgs; [
            godot
        ];
    };
}
