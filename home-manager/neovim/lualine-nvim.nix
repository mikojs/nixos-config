{
  pkgs,
  ...
}:
{
  home.file.".docs/neovim/lualine-nvim.md".text = ''
    # Neovim lualine.nvim

    Lualine.nvim is a statusline plugin for Neovim.

    [Repository](https://github.com/nvim-lualine/lualine.nvim)

  '';

  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = lualine-nvim;
      type = "lua";
      config = ''
        require("lualine").setup({
          options = {
             theme = "onenord",
          },
        })
      '';
    }
  ];
}
