{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = todo-comments-nvim;
      type = "lua";
      config = ''
        require("todo-comments").setup()
        require("which-key").add({
          { "<leader>O", "<Cmd>TodoTelescope<CR>", desc = "Show TODOs" },
        })
      '';
    }
  ];
}
