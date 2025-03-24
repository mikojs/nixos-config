{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = crates-nvim;
      config = ''
        lua << END
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
            { "<leader>c", group = "Crates", mode = { "n", "v" } },
            { "<leader>cR", crates.reload, desc = "Reload data" },
            { "<leader>ct", crates.toggle, desc = "Enable or disable info"  },
            { "<leader>ce", crates.expand_plain_crate_to_inline_table, desc = "Expand crate" },
            { "<leader>cu", crates.upgrade_crate, desc = "Upgrade crate", mode = "n" },
            { "<leader>cu", function() crates.upgrade_crates() end, desc = "Upgrade crates", mode = "v" },
            { "<leader>ch", crates.open_homepage, desc = "Open homepage" },
            { "<leader>cr", crates.open_repository, desc = "Open repository" },
            { "<leader>cd", crates.open_documentation, desc = "Open documentation" },
            { "<leader>cc", crates.open_crates_io, desc = "Open crates.io" },
            { "<leader>cs", crates.show_popup, desc = "Show crate details" },
          })
        END
      '';
    }
  ];
}
