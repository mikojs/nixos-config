{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = octo-nvim;
      type = "lua";
      config = ''
        require("octo").setup()
      '';
    }
  ];
}
