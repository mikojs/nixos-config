{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = lualine-nvim;
      config = ''
        lua << END
          require("lualine").setup({
            options = {
               theme = "onenord",
            }
          })
        END
      '';
    }
  ];
}
