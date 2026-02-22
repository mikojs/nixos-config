{
  pkgs,
  ...
}:
{
  home.file = (import ../../../lib.nix).getDocs pkgs [
    {
      filePath = "neovim/todo-comments-nvim";
      docs = ''
        # Neovim todo-comments.nvim

        Todo-comments.nvim is a todo comments plugin for Neovim.

        [Repository](https://github.com/folke/todo-comments.nvim)

        ## Keybindings

        | Description | Key          |
        | ---         | ---          |
        | Show TODOs  | `<leader>O`  |

      '';
    }
  ];

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
