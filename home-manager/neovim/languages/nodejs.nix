{
  pkgs,
  ...
}:
{
  home.file = {
    ".docs/neovim/package-info-nvim.md".text = ''
      # package-info.nvim

      A neovim plugin that provides information about npm packages.

      [Repository](https://github.com/vuki656/package-info.nvim)

      ## Keybindings

      | Description               | Key          |
      | ---                       | ---          |
      | Enable or disable info    | `<leader>nt` |
      | Update dependency         | `<leader>nu` |
      | Change dependency version | `<leader>nc` |

    '';
  };

  programs.neovim.plugins = with pkgs.vimPlugins; [
    nui-nvim

    {
      plugin = package-info-nvim;
      type = "lua";
      config = ''
        local package_info = require("package-info")

        package_info.setup()
        require("which-key").add({
          { "<leader>nt", package_info.toggle, desc = "Enable or disable info" },
          { "<leader>nu", package_info.update, desc = "Update dependency" },
          { "<leader>nc", package_info.change_version, desc = "Change dependency version" },
        })
      '';
    }
  ];
}
