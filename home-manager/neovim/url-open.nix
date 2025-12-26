{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = url-open;
      type = "lua";
      config = ''
        require("url-open").setup({})
        require("which-key").add({
          { "<leader>o", URLOpenUnderCursor, desc = "Open url" },
        })
      '';
    }
  ];
}
