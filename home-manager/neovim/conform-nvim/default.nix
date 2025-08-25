{
  pkgs,
  lib,
  languages,
  ...
}:
with lib;
with builtins;
let
  getConfig =
    (import ../../../lib.nix).getConfig
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
  home.packages = getConfig [ "packages" ] [ ];

  programs.neovim.plugins =
    with pkgs.vimPlugins;
    with builtins;
    [
      {
        plugin = conform-nvim;
        type = "lua";
        config = ''
          ${getConfig [ "init" ] ""}

          require("conform").setup({
            formatters_by_ft = {
              ${getConfig [ "formatter" ] ""}
            },
            format_on_save = function(bufnr)
              if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
              end

              return { timeout_ms = 500, lsp_format = "fallback" }
            end,
          })

          require("which-key").add({
            { "<leader>cc", group = "Conform" },
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
