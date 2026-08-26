{
    config,
    pkgs,
    lib,
    ...
}:
{
    options = {
        tailscale.enable = lib.mkEnableOption "enable tailscale";
    };

    config = lib.mkIf config.tailscale.enable {
        services.tailscale.enable = true;
        networking.firewall.trustedInterfaces = [ "tailscale0" ];
    };
}
