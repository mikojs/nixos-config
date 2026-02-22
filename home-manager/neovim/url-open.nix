{
  pkgs,
  ...
}:
{
  home.file =
    with pkgs.miko;
    getDocs [
      {
        filePath = "neovim/url-open";
        docs = ''
          # Neovim url-open

          Minimal plugin allow you to open url under cursor in neovim without netrw with default browser of your system and highlight url.

          [Repository](https://github.com/sontungexpt/url-open)

          ## Keybindings

          | Description           | Key       |
          | ---                   | ---       |
          | Open url under cursor | <leader>o |
        '';
      }
    ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = url-open;
      type = "lua";
      config = ''
        require("url-open").setup({})
        require("which-key").add({
          { "<leader>o", "<Cmd>URLOpenUnderCursor<CR>", desc = "Open url under cursor" },
        })
      '';
    }
  ];
}
