{
  pkgs,
  ...
}:
{
  home.file.".docs/neovim/crates-nvim.md".text = ''
    # crates.nvim

    A neovim plugin that helps managing crates.io dependencies.

    [Repository](https://github.com/saecki/crates.nvim)

    ## Keybindings

    | Description             | Key          |
    | ---                     | ---          |
    | Reload data             | `<leader>CR` |
    | Enable or disable info  | `<leader>Ct` |
    | Expand crate            | `<leader>Ce` |
    | Upgrade crate           | `<leader>Cu` |
    | Open homepage           | `<leader>Ch` |
    | Open repository         | `<leader>Cr` |
    | Open documentation      | `<leader>Cd` |
    | Open crates.io          | `<leader>Cc` |
    | Show crate details      | `<leader>Cs` |

  '';

  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = crates-nvim;
      type = "lua";
      config = ''
        local crates = require("crates")

        crates.setup({
          popup = {
            autofocus = true,
          },
          lsp = {
            enabled = true,
            actions = true,
            completion = true,
            hover = true,
          },
        })

        require("which-key").add({
          { "<leader>CR", crates.reload, desc = "Reload data" },
          { "<leader>Ct", crates.toggle, desc = "Enable or disable info"  },
          { "<leader>Ce", crates.expand_plain_crate_to_inline_table, desc = "Expand crate" },
          { "<leader>Cu", crates.upgrade_crate, desc = "Upgrade crate", mode = "n" },
          { "<leader>Cu", function() crates.upgrade_crates() end, desc = "Upgrade crates", mode = "v" },
          { "<leader>Ch", crates.open_homepage, desc = "Open homepage" },
          { "<leader>Cr", crates.open_repository, desc = "Open repository" },
          { "<leader>Cd", crates.open_documentation, desc = "Open documentation" },
          { "<leader>Cc", crates.open_crates_io, desc = "Open crates.io" },
          { "<leader>Cs", crates.show_popup, desc = "Show crate details" },
        })
      '';
    }
  ];
}
