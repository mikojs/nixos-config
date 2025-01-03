{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = crates-nvim;
      config = ''
        lua << END
          require('crates').setup()
        END
      '';
    }
  ];
}
