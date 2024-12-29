{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = todo-comments-nvim;
      config = ''
        lua << END
          require("todo-comments").setup()
          require("which-key").add({
            { "<leader>O", "<Cmd>TodoTelescope<CR>", desc = "Show TODOs" },
          })
        END
      '';
    }
  ];
}
