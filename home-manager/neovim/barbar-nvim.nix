{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    nvim-web-devicons

    {
      plugin = barbar-nvim;
      config = ''
        lua << END
        END
      '';
    }
  ];
}
