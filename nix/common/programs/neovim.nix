{ config, lib, pkgs, ... }:
{
    options.neovim.enable = lib.mkEnableOption "enable neovim";

    config = lib.mkIf config.neovim.enable {
        environment.systemPackages = with pkgs; [
            vimPlugins.nvim-treesitter.withAllGrammars 
            neovim
        ];
    };
}
