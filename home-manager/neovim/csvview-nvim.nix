{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = csvview-nvim;
      type = "lua";
      config = ''
        require("csvview").setup()
      '';
    }
  ];
}
