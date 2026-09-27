{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.modules.dev.dotnet.enable {
    environment.systemPackages = with pkgs; [
      roslyn-ls
    ];
  };
}
