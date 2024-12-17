{ pkgs
, ...
}: {
  home.packages = [ ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = which-key-nvim;
      config = ''
        lua << END
          require('which-key').setup({
            icons = {
              mappings = false,
              keys = {
                Space = 'Space',
                Esc = 'Esc',
                BS = 'Backspace',
                C = 'Ctrl-',
              },
            },
          })
        END
      '';
    }
  ];
}
