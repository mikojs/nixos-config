{
  ai,
  mcpServers ? { },
  languages,
  ...
}:
{
  lib,
  pkgs,
  isWSL,
  ...
}:
with builtins;
let
  getConfig =
    (import ../../lib.nix).getConfig
      (
        [
          # Colorschema
          ./onenord-nvim.nix
          # UI
          ./lualine-nvim.nix
          # Lsp
          ./nvim-treesitter.nix
          ./nvim-cmp
          # Editor
          ./vim-rzip.nix
          ./url-open.nix
          ./which-key-nvim.nix
          ./telescope-nvim.nix
          ./gitsigns-nvim.nix
          ./toggleterm-nvim.nix
          ./barbar-nvim.nix
          ./persistence-nvim.nix
          ./todo-comments-nvim.nix
          # Viewer
          ./markview-nvim.nix
          # Coding
          ./mini-nvim.nix
          ./octo-nvim.nix
          # Formatting
          ./conform-nvim
          # AI
          ./windsurf-nvim.nix
        ]
        ++ (filter pathExists (map (l: ./languages/${l.language}.nix) languages))
      )
      {
        inherit
          lib
          pkgs
          ai
          mcpServers
          languages
          ;
      };
in
{
  home = {
    file =
      getConfig
        [
          "home"
          "file"
        ]
        {
          ".docs/neovim.md".text = ''
            # Neovim

            Neovim is a Vim-fork focused on extensibility and agility.

            [Repository](https://github.com/neovim/neovim)

            ## Keybindings

            | Description        | Key           |
            | ---                | ---           |
            | Increase 10 height | `<leader>wh+` |
            | Decrease 10 height | `<leader>wh-` |
            | Increase 20 width  | `<leader>ww+` |
            | Decrease 20 width  | `<leader>ww-` |

            | Description             | Key          |
            | ---                     | ---          |
            | Copy current file path  | `<leader>cf` |
            | Copy relative file path | `<leader>cr` |

            | Description                      | Key          |
            | ---                              | ---          |
            | Toggle diagnostics virtual lines | `<leader>dt` |

          '';
        };

    packages =
      getConfig
        [
          "home"
          "packages"
        ]
        [ ];
  };

  xdg.configFile = getConfig [
    "xdg"
    "configFile"
  ] { };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins =
      getConfig
        [
          "programs"
          "neovim"
          "plugins"
        ]
        [ ];

    extraConfig = ''
      set encoding=utf-8
      set nu
      set ruler

      " tab setting
      set expandtab
      set tabstop=2
      set shiftwidth=2
      retab

      " set backspace
      set backspace=indent,eol,start

      " set clipboard
      set clipboard=unnamedplus

      " disable compatibility
      set nocompatible

      " fold
      set foldmethod=expr
      set foldexpr=nvim_treesitter#foldexpr()
      set foldtext=getline(v:foldstart).'...'.trim(getline(v:foldend))
      set foldnestmax=3
      set foldminlines=1
    '';

    extraLuaConfig = with lib; ''
      -- Clipboard
      if ${boolToString isWSL} or os.getenv("SSH_CONNECTION") then
        local function paste()
          return {
            vim.split(vim.fn.getreg(""), '\n'),
            vim.fn.getregtype(""),
          }
        end

        vim.g.clipboard = {
          name = "OSC 52",
          copy = {
            ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
            ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
          },
          paste = {
            ["+"] = paste,
            ["*"] = paste,
          },
        }
      end

      -- Window
      require("which-key").add({
        { "<leader>wh+", "<Cmd>resize +10<CR>", desc = "Increase 10 height" },
        { "<leader>wh-", "<Cmd>resize -10<CR>", desc = "Decrease 10 height" },
        { "<leader>ww+", "<Cmd>vertical resize +20<CR>", desc = "Increase 20 width" },
        { "<leader>ww-", "<Cmd>vertical resize -20<CR>", desc = "Decrease 20 width" },
      })

      -- Copy
      require("which-key").add({
        { "<leader>cf", function() vim.fn.setreg('+', vim.fn.expand('%:p')) end, desc = "Copy current file path" },
        { "<leader>cr", function() vim.fn.setreg('+', vim.fn.expand('%')) end, desc = "Copy relative file path" },
      })

      -- Diagnostics
      vim.diagnostic.config({ virtual_lines = true })

      require("which-key").add({
        {
          "<leader>dt",
          function() vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines }) end,
          desc = "Toggle diagnostics virtual lines"
        },
      })
    '';
  };
}
