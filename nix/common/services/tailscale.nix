{
    config,
    pkgs,
    lib,
    ...
}:
{
    config = lib.mkIf config.modules.services.tailscale.enable {
        services.tailscale.enable = true;
        networking.firewall.trustedInterfaces = [ "tailscale0" ];
    };
}
