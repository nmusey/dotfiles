{ config, lib, pkgs, ... }:
{
  options = {
    neovim.enable = lib.mkEnableOption "enable neovim";
  };

  config = lib.mkIf config.neovim.enable
    {
      users.users.${config.username} =
        {
          packages = with pkgs; [ 
            vimPlugins.nvim-treesitter.withAllGrammars 
            neovim
          ];
        };

      environment.systemPackages = with pkgs; [ 
        neovim
      ];
    };
}
