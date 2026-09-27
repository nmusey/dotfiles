{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.modules.services.ssh.enable {
    environment.systemPackages = with pkgs; [
      openssh
    ];

    environment.enableAllTerminfo = true;
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
