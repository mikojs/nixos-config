{
  pkgs,
  languages,
  ...
}:
{
  home.packages = with pkgs; [ libgccjit ];

  programs.neovim.plugins =
    with pkgs.vimPlugins;
    with builtins;
    [
      (nvim-treesitter.withPlugins (
        p:
        foldl' (
          result: l:
          if l.language == "nodejs" then
            result
            ++ [
              p.javascript
              p.typescript
              p.tsx
            ]
          else if l.language == "postgresql" || l.language == "sqlite" then
            result ++ [ p.sql ]
          else
            result ++ [ p."${l.language}" ]
        ) [ p.c p.lua p.vimdoc ] languages
      ))

      {
        plugin = nvim-treesitter;
        type = "lua";
        config = ''
          vim.opt.foldmethod = "expr"
          vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
          vim.opt.foldenable = false

          require("nvim-treesitter.configs").setup({
            auto_install = false,
            highlight = {
              enable = true,
            },
          })
        '';
      }
    ];
}
