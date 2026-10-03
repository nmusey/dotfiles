{ config, lib, ... }:
let
  cfg = config.modules.services.personalnet;
  subnet = "10.42.0.0/24";
in
{
  config = lib.mkIf cfg.enable {
    systemd.services.nordvpn-allowlist-personalnet = lib.mkIf config.modules.services.nordvpn.enable {
      description = "Allowlist the personal network in NordVPN";
      wantedBy = [ "multi-user.target" ];
      wants = [ "nordvpnd.service" ];
      after = [ "nordvpnd.service" ];
      path = [ config.services.nordvpn.package ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        User = config.variables.global.username;
      };
      script = ''
        for _ in $(seq 30); do
          if settings=$(nordvpn settings 2>&1); then
            echo "$settings" | grep -qF "${subnet}" || nordvpn allowlist add subnet ${subnet}
            # new DHCP clients send from 0.0.0.0, which the subnet allowlist doesn't cover
            nordvpn allowlist add ports 67 68 protocol UDP
            exit
          fi
          sleep 1
        done
        echo "nordvpnd did not respond: $settings" >&2
        exit 1
      '';
    };

    networking.networkmanager.ensureProfiles.profiles.personal = {
      connection = {
        id = "personal";
        type = "ethernet";
        interface-name = cfg.lanInterface;
        autoconnect = true;
      };
      ipv4 = {
        method = "shared";
        address1 = "10.42.0.1/24";
      };
      ipv6.method = "disabled";
    };

    networking.firewall.interfaces.${cfg.lanInterface} = {
      allowedTCPPorts = [ 53 ];
      allowedUDPPorts = [
        53
        67
      ];
    };
  };
}
