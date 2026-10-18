{
  config,
  pkgs,
  lib,
  ...
}:
let
  port = 5900;
  home = config.users.users.${config.variables.global.username}.home;
  keyFile = "${home}/.local/state/wayvnc/rsa_key.pem";

  configFile = pkgs.writeText "wayvnc-config" ''
    address=0.0.0.0
    port=${toString port}
    enable_auth=true
    enable_pam=true
    rsa_private_key_file=${keyFile}
  '';
in
{
  config = lib.mkIf config.modules.services.wayvnc.enable {
    environment.systemPackages = [ pkgs.wayvnc ];

    security.pam.services.wayvnc = { };

    systemd.user.services.wayvnc = {
      description = "VNC server for the Hyprland session";
      wantedBy = [ "hyprland-session.target" ];
      partOf = [ "hyprland-session.target" ];
      after = [ "hyprland-session.target" ];
      path = [ pkgs.openssh ];
      preStart = ''
        [ -f ${keyFile} ] || ssh-keygen -q -m pem -t rsa -N "" -f ${keyFile}
      '';
      serviceConfig = {
        ExecStart = "${pkgs.wayvnc}/bin/wayvnc --config=${configFile} --desktop";
        StateDirectory = "wayvnc";
        Restart = "on-failure";
        RestartSec = 2;
      };
    };

    networking.firewall.allowedTCPPorts = [ port ];

    systemd.services.nordvpn-allowlist-wayvnc = lib.mkIf config.modules.services.nordvpn.enable {
      description = "Allowlist the wayvnc port in NordVPN";
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
          if out=$(nordvpn allowlist add port ${toString port} protocol TCP 2>&1); then
            exit
          fi
          case "$out" in
            *"already on the allowlist"*) exit 0 ;;
          esac
          sleep 1
        done
        echo "nordvpnd did not respond: $out" >&2
        exit 1
      '';
    };
  };
}
