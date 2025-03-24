{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = package-info-nvim;
      config = ''
        lua << END
          local package_info = gerequire('package-info')

          package_info.setup()

          require("which-key").add({
            { "<leader>n", group = "Node packages" },
            { "<leader>nt", package_info.toggle, desc = "Enable or disable info" },
            { "<leader>nu", package_info.update, desc = "Update dependency },
          })
        END
      '';
    }
  ];
}
