{ config, lib, pkgs, ... }:
{
    config = lib.mkIf config.modules.services.ntfs.enable {
        boot.supportedFilesystems = [ "ntfs" ];

        environment.systemPackages = with pkgs; [
          ntfs3g
        ];
    };
}
