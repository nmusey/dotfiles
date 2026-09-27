{
    config,
    pkgs,
    lib,
    ...
}:
{
    config = lib.mkIf config.modules.services.sync.enable {
        users.groups.sync = { };
        users.users.${config.variables.global.username}.extraGroups = [ "sync" ];
        users.users.syncthing = {
            isSystemUser = true;
            extraGroups = [ "sync" "srv" ];
            shell = "${pkgs.shadow}/bin/nologin";
        };

        services.syncthing = {
            enable = true;
            user = "syncthing";
            group = "syncthing";

            openDefaultPorts = true;

            guiAddress = "0.0.0.0:8384";
            guiPasswordFile = "/etc/syncthing-gui-pwd";
            settings = {
                gui.user = "nick";
                devices = {
                    "mba" = { id = "UHNERDS-SLAXVWY-FCXJ4G3-7UO4JEK-ECWQCZ5-ZLSHXBV-OPLH3QP-3IO5YAH"; };
                };
                folders = {
                    "Sync" = {
                        path = "/srv/Documents/Sync";
                        devices = [ "mba" ];
                        ignorePerms = true;
                    };
                };
            };
        };

        systemd.services.syncthing.serviceConfig.UMask = "0002";
        systemd.tmpfiles.rules = [
          "d /srv/Documents      0755 ${config.variables.global.username} srv  -"
          "d /srv/Documents/Sync 2775 ${config.variables.global.username} sync -"
        ];
    };
}
