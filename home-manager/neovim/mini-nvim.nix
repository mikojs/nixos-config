{ pkgs
, ...
}: {
  home.packages = [ ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = mini-icons;
      config = ''
        lua << END
          require('mini.icons').setup();
        END
      '';
    }

    {
      plugin = mini-ai;
      config = ''
        lua << END
          require('mini.ai').setup();
        END
      '';
    }

    {
      plugin = mini-comment;
      config = ''
        lua << END
          require('mini.comment').setup();
        END
      '';
    }

    {
      plugin = mini-surround;
      config = ''
        lua << END
          require('mini.surround').setup();
        END
      '';
    }

    {
      plugin = mini-notify;
      config = ''
        lua << END
          require('mini.notify').setup();
        END
      '';
    }

    {
      plugin = mini-pairs;
      config = ''
        lua << END
          require('mini.pairs').setup();
        END
      '';
    }

    {
      plugin = mini-trailspace;
      config = ''
        lua << END
          require('mini.trailspace').setup();
        END
      '';
    }

    {
      plugin = mini-bracketed;
      config = ''
        lua << END
          require('mini.bracketed').setup();
        END
      '';
    }

    {
      plugin = mini-move;
      config = ''
        lua << END
          require('mini.move').setup();
        END
      '';
    }
  ];
}
