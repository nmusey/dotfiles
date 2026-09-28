{
    config,
    lib,
    pkgs,
    ...
}:
{
    config = lib.mkIf config.modules.dev.unity.enable {
        environment.systemPackages = with pkgs; [
            unityhub
            roslyn-ls
            dotnetCorePackages.sdk_10_0
        ];
    };
}
