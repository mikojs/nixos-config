{
  pkgs,
  languages,
  ...
}:
{
  home.packages = with pkgs; [ libgccjit ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    (nvim-treesitter.withPlugins (
      p:
      map
        (
          l:
          if l.language == "nodejs" then
            p.javascript
          else if l.language == "postgresql" then
            p.sql
          else
            p."${l.language}"
        )
        (
          [
            { language = "c"; }
            { language = "lua"; }
            { language = "vimdoc"; }
          ]
          ++ languages
        )
    ))

    {
      plugin = nvim-treesitter;
      config = ''
        lua << END
          vim.opt.foldmethod = "expr"
          vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
          vim.opt.foldenable = false

          require("nvim-treesitter.configs").setup({
            auto_install = false,
            highlight = {
              enable = true,
            },
          })
        END
      '';
    }
  ];
}
