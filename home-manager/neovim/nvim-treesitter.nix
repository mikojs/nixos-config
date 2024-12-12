{ pkgs
, languages
, ...
}: {
  home.packages = with pkgs; [ libgccjit ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    (nvim-treesitter.withPlugins (p: map
      (language:
        if language == "nodejs" then p.javascript
        else p."${language}"
      )
      ([ "c" "lua" "vimdoc" ] ++ languages)))

    {
      plugin = nvim-treesitter;
      config = ''
        lua << END
          require'nvim-treesitter.configs'.setup {
            auto_install = false,
            highlight = {
              enable = true,
              disable = { 'comment' },
            },
            indent = {
              enable = true,
            },
          }
        END
      '';
    }
  ];
}
