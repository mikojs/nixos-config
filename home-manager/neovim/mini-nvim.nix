{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = mini-icons;
      config = ''
        lua << END
          require("mini.icons").setup()
        END
      '';
    }

    {
      plugin = mini-notify;
      config = ''
        lua << END
          require("mini.notify").setup()
        END
      '';
    }

    {
      plugin = mini-trailspace;
      config = ''
        lua << END
          require("mini.trailspace").setup()
        END
      '';
    }

    {
      plugin = mini-files;
      config = ''
        lua << END
          local mini_files = require("mini.files")

          mini_files.setup({
            mappings = {
              mark_goto = "",
              mark_set = "",
              reveal_cwd = "",
            },
          })
          require("which-key").add({
            { "<leader>f", mini_files.open, desc = "Manipulate files" },
          })
        END
      '';
    }

    {
      plugin = mini-ai;
      config = ''
        lua << END
          require("mini.ai").setup({
            n_lines = 200,
            mappings = {
              around_next = "",
              inside_next = "",
              around_last = "",
              inside_next = "",
            },
          })
        END
      '';
    }

    {
      plugin = mini-surround;
      config = ''
        lua << END
          require("mini.surround").setup({
            n_lines = 200,
          })
        END
      '';
    }

    {
      plugin = mini-bracketed;
      config = ''
        lua << END
          require("mini.bracketed").setup()
        END
      '';
    }

    {
      plugin = mini-comment;
      config = ''
        lua << END
          require("mini.comment").setup()
        END
      '';
    }

    {
      plugin = mini-move;
      config = ''
        lua << END
          require("mini.move").setup()
        END
      '';
    }

    {
      plugin = mini-align;
      config = ''
        lua << END
          require("mini.align").setup()
        END
      '';
    }
  ];
}
