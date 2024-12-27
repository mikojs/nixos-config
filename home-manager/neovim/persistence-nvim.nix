{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = persistence-nvim;
      config = ''
        lua << END
          require("persistence").setup({
            need = 0,
          })
        END
      '';
    }
  ];
}
