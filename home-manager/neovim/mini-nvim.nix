{
  pkgs,
  ...
}:
{
  home.file =
    with pkgs.miko;
    getDocs [
      {
        filePath = "neovim/mini-nvim";
        docs = ''
          # Neovim mini.nvim

          Mini.nvim is a plugin for Neovim that provides small utilities.

          [Repository](https://github.com/echasnovski/mini.nvim)
        '';
      }
      {
        filePath = "neovim/mini-nvim/mini-icons";
        docs = ''
          # Mini.nvim mini.icons

          Mini.icons is an icon provider.

          [Repository](https://github.com/echasnovski/mini.icons)
        '';
      }
      {
        filePath = "neovim/mini-nvim/mini-notify";
        docs = ''
          # Mini.nvim mini.notify

          Mini.notify is a notification plugin for Neovim.

          [Repository](https://github.com/echasnovski/mini.notify)
        '';
      }
      {
        filePath = "neovim/mini-nvim/mini-trailspace";
        docs = ''
          # Mini.nvim mini.trailspace

          Mini.trailspace is a trailing space highlighter.

          [Repository](https://github.com/echasnovski/mini.trailspace)
        '';
      }
      {
        filePath = "neovim/mini-nvim/mini-files";
        docs = ''
          # Mini.nvim mini.files

          Mini.files is a file explorer for Neovim.

          [Repository](https://github.com/echasnovski/mini.files)

          ## Keybindings

          | Description         | Key         |
          | ---                 | ---         |
          | Manipulate files    | `<leader>f` |
          | Close explorer      | `q`         |
          | Go into directory   | `l`         |
          | Go out of directory | `h`         |
          | Reset file explorer | `<BS>`      |
          | Sync file explorer  | `=`         |
        '';
      }
      {
        filePath = "neovim/mini-nvim/mini-ai";
        docs = ''
          # Mini.nvim mini.ai

          Mini.ai is a textobject plugin for Neovim.

          [Repository](https://github.com/echasnovski/mini.ai)

          ## Keybindings

          | Description                    | Key  |
          | ---                            | ---  |
          | Find arround textobject        | `a`  |
          | Find inside textobject         | `i`  |
          | Go to left arround textobject  | `g[` |
          | Go to right arround textobject | `g]` |
        '';
      }
      {
        filePath = "neovim/mini-nvim/mini-surround";
        docs = ''
          # Mini.nvim mini.surround

          Mini.surround is a surround plugin for Neovim.

          [Repository](https://github.com/echasnovski/mini.surround)

          ## Keybindings

          | Description                                | Key  |
          | ---                                        | ---  |
          | Add surrounding in Normal and Visual modes | `sa` |
          | Delete surrounding                         | `sd` |
          | Find surrounding (to the right)            | `sf` |
          | Find surrounding (to the left)             | `sF` |
          | Highlight surrounding                      | `sh` |
          | Replace surrounding                        | `sr` |
          | Update n_lines                             | `sn` |
          | Suffix to search with "prev" method        | `l`  |
          | Suffix to search with "next" method        | `n`  |
        '';
      }
      {
        filePath = "neovim/mini-nvim/mini-bracketed";
        docs = ''
          # Mini.nvim mini.bracketed

          Go forward/backward with square brackets

          [Repository](https://github.com/echasnovski/mini.bracketed)

          ## Keybindings

          | Description                                       | Key                 |
          | ---                                               | ---                 |
          | Buffer                                            | `[B` `[b` `]b` `]B` |
          | Comment block                                     | `[C` `[c` `]c` `]C` |
          | Conflict marker                                   | `[X` `[x` `]x` `]X` |
          | Diagnostic                                        | `[D` `[d` `]d` `]D` |
          | File on disk                                      | `[F` `[f` `]f` `]F` |
          | Indent change                                     | `[I` `[i` `]i` `]I` |
          | Jump from jumplist                                | `[J` `[j` `]j` `]J` |
          | Location from location list                       | `[L` `[l` `]l` `]L` |
          | Old files                                         | `[O` `[o` `]o` `]O` |
          | Quickfix entry from quickfix list                 | `[Q` `[q` `]q` `]Q` |
          | Tree-sitter node and parents                      | `[T` `[t` `]t` `]T` |
          | Undo states from specially tracked linear history | `[U` `[u` `]u` `]U` |
          | Window in current tab                             | `[W` `[w` `]w` `]W` |
          | Yank selection replacing latest put region        | `[Y` `[y` `]y` `]Y` |
        '';
      }
      {
        filePath = "neovim/mini-nvim/mini-comment";
        docs = ''
          # Mini.nvim mini.comment

          Comment lines

          [Repository](https://github.com/echasnovski/mini.comment)

          ## Keybindings

          | Description                    | Key   |
          | ---                            | ---   |
          | Toggle comment                 | `gc`  |
          | Toggle comment on current line | `gcc` |
        '';
      }
      {
        filePath = "neovim/mini-nvim/mini-move";
        docs = ''
          # Mini.nvim mini.move

          Move any selection in any direction

          [Repository](https://github.com/echasnovski/mini.move)

          Keybindings

          | Description | Key     |
          | ---         | ---     |
          | Move left   | `<M-h>` |
          | Move right  | `<M-l>` |
          | Move down   | `<M-j>` |
          | Move up     | `<M-k>` |
        '';
      }
      {
        filePath = "neovim/mini-nvim/mini-align";
        docs = ''
          ### Mini.nvim mini.align

          Align text interactively

          [Repository](https://github.com/echasnovski/mini.align)

          ## Keybindings

          | Description                           | Key  |
          | ---                                   | ---  |
          | Align text interactively              | `ga` |
          | Align text interactively with preview | `gA` |

          | Description             | Key  |
          | ---                     | ---  |
          | Enter split pattern     | `s`  |
          | Choose justify side     | `j`  |
          | Enter merge delimiter   | `m`  |
          | Enhanced setup for '='  | `=`  |
          | Enhanced setup for ','  | `,`  |
          | Enhanced setup for '\|' | `\|` |
          | Enhanced setup for ' '  | ` `  |
        '';
      }
    ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = mini-icons;
      type = "lua";
      config = ''
        require("mini.icons").setup()
      '';
    }

    {
      plugin = mini-notify;
      type = "lua";
      config = ''
        require("mini.notify").setup()
      '';
    }

    {
      plugin = mini-trailspace;
      type = "lua";
      config = ''
        require("mini.trailspace").setup()
      '';
    }

    {
      plugin = mini-files;
      type = "lua";
      config = ''
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
      '';
    }

    {
      plugin = mini-ai;
      type = "lua";
      config = ''
        require("mini.ai").setup({
          n_lines = 200,
          mappings = {
            around_next = "",
            inside_next = "",
            around_last = "",
            inside_next = "",
          },
        })
      '';
    }

    {
      plugin = mini-surround;
      type = "lua";
      config = ''
        require("mini.surround").setup({
          n_lines = 200,
        })
      '';
    }

    {
      plugin = mini-bracketed;
      type = "lua";
      config = ''
        require("mini.bracketed").setup()
      '';
    }

    {
      plugin = mini-comment;
      type = "lua";
      config = ''
        require("mini.comment").setup()
      '';
    }

    {
      plugin = mini-move;
      type = "lua";
      config = ''
        require("mini.move").setup()
      '';
    }

    {
      plugin = mini-align;
      type = "lua";
      config = ''
        require("mini.align").setup()
      '';
    }
  ];
}
