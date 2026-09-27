{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.modules.programs.neovim.enable {
    environment.systemPackages = with pkgs; [
      vimPlugins.nvim-treesitter.withAllGrammars
      neovim
    ];
  };
}
