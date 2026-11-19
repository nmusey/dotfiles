{ config, lib, ... }:
{
  config = lib.mkIf config.modules.services.audiobookshelf.enable {
    services.audiobookshelf = {
      enable = true;
      port = 13378;
    };
    users.users.audiobookshelf.extraGroups = [ "media" ];
    modules.services.media.enable = true;

    modules.services.caddy.hosts.books.port = config.services.audiobookshelf.port;
  };
}
