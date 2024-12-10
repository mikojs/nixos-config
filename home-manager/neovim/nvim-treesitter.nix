{ pkgs
, languages
, ...
}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    (nvim-treesitter.withPlugins (p: map (language: p."${language}") languages))

    {
      plugin = nvim-treesitter;
      config = ''
        lua << END
          require'nvim-treesitter.configs'.setup {
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
