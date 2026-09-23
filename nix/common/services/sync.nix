{
    config,
    pkgs,
    lib,
    ...
}:
{
    options = {
        sync.enable = lib.mkEnableOption "enable sync packages between systems";
    };

    config = lib.mkIf config.sync.enable {
        services.syncthing = {
            enable = true;
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
                        path = "/home/nick/Documents/Sync/";
                    };
                };
            };
        };
    };
}
