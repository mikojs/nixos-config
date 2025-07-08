{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = csvview-nvim;
      config = ''
        lua << END
          require("csvview").setup()
        END
      '';
    }
  ];
}
