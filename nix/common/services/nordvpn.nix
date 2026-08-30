{
    config,
    lib,
    pkgs,
    ...
}:
{
    options = {
        nordvpn.enable = lib.mkEnableOption = "Enable NordVPN with modifications to make it work";
    }

    config = lib.mkIf config.nordvpn.enable = {
        services.nordvpn.enable = true;
        networking.firewall.checkReversePath = "loose";
        security.polkit.extraConfig = ''
          polkit.addRule(function(action, subject) {
            if (action.id.indexOf("org.freedesktop.resolve1.") === 0
                && subject.isInGroup("nordvpn")) {
              return polkit.Result.YES;
            }
          });
        '';
    };
}
