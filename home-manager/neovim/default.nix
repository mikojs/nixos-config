{
  ai,
  languages,
  ...
}:
{
  lib,
  pkgs,
  miko,
  isWSL,
  ...
}:
with builtins;
let
  getConfig =
    miko.getConfig
      (
        [
          # Colorschema
          ./onenord-nvim.nix
          # UI
          ./lualine-nvim.nix
          # Lsp
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
          miko
          ai
          languages
          ;
      };

  # FIXME: https://github.com/nix-community/nixvim/discussions/4304
  treesitterPlugins = pkgs.vimUtils.buildVimPlugin {
    name = "treesitter-plugins";

    doCheck = false;

    src = pkgs.fetchFromGitHub {
      owner = "nvim-treesitter";
      repo = "nvim-treesitter";
      rev = "main";
      sha256 = "sha256-PQR6tFt4lCrAZNQG7BLMD1IiCKja9wDS1S4laGJf/HE=";
    };

    postInstall = ''
      rm -rf $out/*
      rm -rf $out/.* 2>/dev/null || true

      mkdir -p $out/parser
      mkdir -p $out/queries

      ${pkgs.lib.concatMapStringsSep "\n"
        (lang: ''
          ln -s ${pkgs.tree-sitter-grammars."tree-sitter-${lang}"}/parser $out/parser/${lang}.so

          if [ -d "runtime/queries/${lang}" ]; then
            cp -r "runtime/queries/${lang}" $out/queries/${lang}
          fi
        '')
        (
          foldl' (
            result: l:
            if l.language == "nodejs" then
              result
              ++ [
                "javascript"
                "typescript"
                "tsx"
              ]
            else if l.language == "postgresql" || l.language == "sqlite" then
              result ++ [ "sql" ]
            else
              result ++ [ l.language ]
          ) [ ] languages
        )
      }
    '';
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
        (
          miko.getDocs [
            {
              filePath = "neovim";
              docs = ''
                # Neovim

                Neovim is a Vim-fork focused on extensibility and agility.

                [Repository](https://github.com/neovim/neovim)

                ## Keybindings

                | Description           | Key           |
                | ---                   | ---           |
                | Increase height by 10 | `<leader>wh+` |
                | Decrease height by 10 | `<leader>wh-` |
                | Increase width by 20  | `<leader>ww+` |
                | Decrease width by 20  | `<leader>ww-` |

                | Description             | Key          |
                | ---                     | ---          |
                | Copy current file path  | `<leader>cf` |
                | Copy relative file path | `<leader>cr` |

                | Description                     | Key          |
                | ---                             | ---          |
                | Toggle diagnostic virtual lines | `<leader>dt` |
              '';
            }
          ]
        );

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
        [ treesitterPlugins ];

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
    '';

    initLua = with lib; ''
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

      -- fold
      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.o.foldlevel = 99
    '';
  };
}
