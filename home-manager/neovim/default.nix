{
  ai,
  languages,
}:
{
  lib,
  pkgs,
  isWSL,
  ...
}:
with builtins;
let
  configs =
    map
      (
        m:
        import ./${m} {
          inherit
            lib
            pkgs
            ai
            languages
            ;
        }
      )
      (
        [
          # Colorschema
          "onenord-nvim.nix"
          # UI
          "lualine-nvim.nix"
          # Lsp
          "nvim-treesitter.nix"
          "nvim-cmp"
          # Editor
          "vim-rzip.nix"
          "which-key-nvim.nix"
          "telescope-nvim.nix"
          "gitsigns-nvim.nix"
          "toggleterm-nvim.nix"
          "barbar-nvim.nix"
          "persistence-nvim.nix"
          "todo-comments-nvim.nix"
          # Viewer
          "markview-nvim.nix"
          # Coding
          "mini-nvim.nix"
          # Formatting
          "conform-nvim"
          # AI
          "windsurf-nvim.nix"
          "avante-nvim.nix"
          "mcphub-nvim.nix"
        ]
        ++ (map (l: "./languages/${l.language}.nix") (
          filter (l: pathExists ./languages/${l.language}.nix) languages
        ))
      );

  getConfig =
    with builtins;
    (
      keys:
      (foldl' (
        result: config:
        let
          data = (
            foldl' (
              result: key: if result != null && hasAttr "${key}" result then result."${key}" else null
            ) config keys
          );
        in
        if data != null then result ++ data else result
      ) [ ] configs)
    );
in
{
  home.packages = getConfig ([
    "home"
    "packages"
  ]);

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = getConfig ([
      "programs"
      "neovim"
      "plugins"
    ]);

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

    extraLuaConfig = ''
      -- Clipboard
      ${
        if !isWSL then
          ""
        else
          ''
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
          ''
      }

      -- Window
      require("which-key").add({
        { "<leader>w", group = "Window" },
        { "<leader>wh", group = "Resize height" },
        { "<leader>wh+", "<Cmd>resize +10<CR>", desc = "Increase 10 height" },
        { "<leader>wh-", "<Cmd>resize -10<CR>", desc = "Decrease 10 height" },
        { "<leader>ww", group = "Resize width" },
        { "<leader>ww+", "<Cmd>vertical resize +20<CR>", desc = "Increase 20 width" },
        { "<leader>ww-", "<Cmd>vertical resize -20<CR>", desc = "Decrease 20 width" },
      })

      -- Copy
      require("which-key").add({
        { "<leader>c", group = "Copy/Conform" },
        { "<leader>cf", function() vim.fn.setreg('+', vim.fn.expand('%:p')) end, desc = "Copy current file path" },
        { "<leader>cr", function() vim.fn.setreg('+', vim.fn.expand('%')) end, desc = "Copy relative file path" },
      })

      -- Diagnostics
      vim.diagnostic.config({ virtual_lines = true })

      require("which-key").add({
        { "<leader>d", group = "Diagnostics" },
        {
          "<leader>dt",
          function() vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines }) end,
          desc = "Toggle diagnostics virtual lines"
        },
      })
    '';
  };
}
