{ config, pkgs, lib, ... }:
{
  options = {
    ssh.enable = lib.mkEnableOption "enable ssh hosting";
  };

  config = lib.mkIf config.ssh.enable {
    environment.systemPackages = with pkgs; [
        openssh
    ];

    services.openssh = {
        enable = true;
        settings.PasswordAuthentication = true;
        settings.KbdInteractiveAuthentication = false;
        settings.PermitRootLogin = "no";
        settings.X11Forwarding = true;
        settings.X11DisplayOffset = 10;
    };
  };
}
