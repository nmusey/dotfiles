{
  config,
  pkgs,
  lib,
  ...
}:
let
  desktopFile = "org.pwmt.zathura-pdf-mupdf.desktop";
  mimeTypes = [
    "application/pdf"
    "application/epub+zip"
    "image/jpeg"
    "image/png"
    "image/bmp"
    "image/x-bmp"
    "image/tiff"
    "image/svg+xml"
  ];
in
{
  config = lib.mkIf config.modules.programs.zathura.enable {
    environment.systemPackages = [ pkgs.zathura ];

    xdg.mime.defaultApplications = lib.genAttrs mimeTypes (_: desktopFile);
  };
}
