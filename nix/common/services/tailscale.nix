{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.services.tailscale;
  routing = cfg.advertiseRoutes != [ ];
in
{
  config = lib.mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      useRoutingFeatures = if routing then "server" else "client";
      extraSetFlags = lib.optional routing "--advertise-routes=${lib.concatStringsSep "," cfg.advertiseRoutes}";
    };
    networking.firewall = {
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ config.services.tailscale.port ];
    };
  };
}
