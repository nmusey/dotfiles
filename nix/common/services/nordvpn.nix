{
    config,
    lib,
    pkgs,
    ...
}:
{
    config = lib.mkIf config.modules.services.nordvpn.enable {
        users.users.${config.variables.global.username}.extraGroups = [ "nordvpn" ];

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
