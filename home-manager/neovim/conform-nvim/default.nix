{
  pkgs,
  lib,
  languages,
  ...
}:
with lib;
with builtins;
with pkgs.miko;
let
  allConfigs =
    getConfig
      (filter pathExists (
        lists.unique (
          map (
            l: if l.language == "postgresql" || l.language == "sqlite" then ./db.nix else ./${l.language}.nix
          ) languages
        )
      ))
      {
        inherit pkgs;
      };
in
{
  home = {
    file = allConfigs [ "file" ] (getDocs [
      {
        filePath = "neovim/conform-nvim";
        docs = ''
          # Neovim conform.nvim

          Conform.nvim is a formatter plugin for Neovim.

          [Repository](https://github.com/stevearc/conform.nvim)

          ## Keybindings

          | Description                        | Key           |
          | ---                                | ---           |
          | Toggle autoformat for all files    | `<leader>ccT` |
          | Toggle autoformat for current file | `<leader>cct` |
        '';
      }
    ]);

    packages = allConfigs [ "packages" ] [ ];
  };

  programs.neovim.plugins =
    with pkgs.vimPlugins;
    with builtins;
    [
      {
        plugin = conform-nvim;
        type = "lua";
        config = ''
          ${allConfigs [ "init" ] ""}

          require("conform").setup({
            formatters_by_ft = {
              ${allConfigs [ "formatter" ] ""}
            },
            format_on_save = function(bufnr)
              if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
              end

              return { timeout_ms = 500, lsp_format = "fallback" }
            end,
          })

          require("which-key").add({
            { "<leader>ccT", function() vim.g.disable_autoformat = not vim.g.disable_autoformat end, desc = "Toggle autoformat for all files" },
            {
              "<leader>cct",
              function() vim.b[vim.api.nvim_get_current_buf()].disable_autoformat = not vim.b[vim.api.nvim_get_current_buf()].disable_autoformat end,
              desc = "Toggle autoformat for current file"
            },
          })
        '';
      }
    ];
}
