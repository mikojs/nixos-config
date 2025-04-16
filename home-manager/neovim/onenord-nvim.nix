{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = onenord-nvim;
      config = ''
        colorscheme onenord
      '';
    }
  ];
}
