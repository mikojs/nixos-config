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
  ];
}
