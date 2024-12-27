{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = persistence-nvim;
      config = ''
        require('persistence').setup({
          need = 0,
        })
      '';
    }
  ];
}
