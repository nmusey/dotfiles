{ config, pkgs, lib, ... }:
{
  options = {
    ssh.enable = lib.mkEnableOption "enable ssh hosting";
  };

  config = lib.mkIf config.ssh.enable {
    users.users.${config.username} = {
      packages = with pkgs; [
        openssh
      ];
    };

    services.openssh = {
      enable = true;
      settings.PasswordAuthentication = true;
      settings.KbdInteractiveAuthentication = false;
      settings.PermitRootLogin = "no";
    };
  };
}
