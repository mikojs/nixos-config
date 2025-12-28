{
  pkgs,
  ...
}:
{
  home.file.".docs/neovim/persistence-nvim.md".text = ''
    # Neovim persistence.nvim

    Persistence.nvim is a session plugin for Neovim.

    [Repository](https://github.com/folke/persistence.nvim)

    ## Keybindings

    | Description            | Key          |
    | ---                    | ---          |
    | Load session           | `<leader>sl` |
    | Select session         | `<leader>sc` |
    | Save auto-save session | `<leader>ss` |

  '';

  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = persistence-nvim;
      type = "lua";
      config = ''
        local persistence = require("persistence")

        persistence.setup({
          need = 1,
          branch = true,
        })

        require("which-key").add({
          { "<leader>sl", function() persistence.load() end, desc ="Load session" },
          { "<leader>sc", function() persistence.select() end, desc = "Select session" },
          { "<leader>ss", function() persistence.stop() end, desc = "Stop auto-save session" },
        })
      '';
    }
  ];
}
