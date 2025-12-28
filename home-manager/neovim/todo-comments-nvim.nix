{
  pkgs,
  ...
}:
{
  home.file.".docs/neovim/todo-comments-nvim.md".text = ''
    # Neovim todo-comments.nvim

    Todo-comments.nvim is a todo comments plugin for Neovim.

    [Repository](https://github.com/folke/todo-comments.nvim)

    ## keybindings

    | Description | Key          |
    | ---         | ---          |
    | Show TODOs  | `<leader>O`  |

  '';

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
