{
  pkgs,
  languages,
  ...
}:
let
  languagesConfig =
    with builtins;
    foldl' (
      result: l:
      let
        language = if l.language == "postgresql" || l.language == "sqlite" then "db" else l.language;
      in
      if pathExists ./${language}.nix then
        result
        ++ [
          (import ./${language}.nix {
            inherit pkgs;
          })
        ]
      else
        result
    ) [ ] languages;
in
{
  home.packages =
    with builtins;
    foldl' (
      result: l: if hasAttr "packages" l then result ++ l.packages else result
    ) [ ] languagesConfig;

  programs.neovim.plugins =
    with pkgs.vimPlugins;
    with builtins;
    [
      {
        plugin = conform-nvim;
        config = ''
          lua << END
            ${concatStringsSep "\n" (
              foldl' (result: l: if hasAttr "init" l then result ++ [ l.init ] else result) [ ] languagesConfig
            )}

            require("conform").setup({
              formatters_by_ft = {
                ${concatStringsSep ",\n" (map (l: l.formatter) languagesConfig)}
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
          END
        '';
      }
    ];
}
