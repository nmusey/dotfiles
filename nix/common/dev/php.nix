{
  config,
  lib,
  pkgs,
  ...
}:
let
  php = pkgs.php.buildEnv {
    extensions = { enabled, all }: enabled ++ (with all; [ xdebug redis ]);
    extraConfig = ''
      memory_limit = 1G
      xdebug.mode = debug
      xdebug.start_with_request = trigger
      xdebug.client_port = 9003
    '';
  };
in
{
  config = lib.mkIf config.modules.dev.php.enable {
    environment.systemPackages = [
      php
      php.packages.composer
      php.packages.php-cs-fixer
      php.packages.php-codesniffer
      php.packages.psalm
    ]
    ++ (with pkgs; [
      laravel

      intelephense
      phpactor
      phpstan
      blade-formatter
    ]);
  };
}
