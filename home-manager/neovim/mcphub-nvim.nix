{
  pkgs,
  ...
}:
{
  home.file = {
    ".docs/neovim/mcphub-nvim.md".text = ''
      # Neovim mcphub.nvim

      Mcphub.nvim is a plugin for Neovim that provides mcp services.
      Also work with `avante` and `lualine`.

      [Repository](https://github.com/ravitemer/mcphub.nvim)

      ```nvim
      :MCPHub ...
      ```

    '';
  };

  programs.neovim.plugins =
    with pkgs;
    with pkgs.vimPlugins;
    [
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
