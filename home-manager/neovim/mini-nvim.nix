{ pkgs
, ...
}: {
  home.packages = [ ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = mini-icons;
      config = ''
        lua << END
          require('mini.icons').setup({});
        END
      '';
    }

    {
      plugin = mini-ai;
      config = ''
        lua << END
          require('mini.ai').setup({});
        END
      '';
    }
  ];
}
