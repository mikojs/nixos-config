{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = mcphub-nvim;
      type = "lua";
      config = ''
        require("mcphub").setup({
          cmd = "${mcp-hub}/bin/mcp-hub"
        })
      '';
    }
  ];
}
