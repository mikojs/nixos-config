{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    nui-nvim

    {
      plugin = package-info-nvim;
      config = ''
        lua << END
          local package_info = require("package-info")

          package_info.setup()

          require("which-key").add({
            { "<leader>n", group = "Node packages" },
            { "<leader>nt", package_info.toggle, desc = "Enable or disable info" },
            { "<leader>nu", package_info.update, desc = "Update dependency" },
            { "<leader>nc", package_info.change_version, desc = "Change dependency version" },
          })
        END
      '';
    }
  ];
}
