{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    nvim-web-devicons

    {
      plugin = barbar-nvim;
      config = ''
        lua << END
          local opts = { noremap = true, silent = true }

          vim.g.barbar_auto_setup = false

          require("barbar").setup({
            icons = {
              pinned = { button = "", filename = true },
              diagnostics = {
                [vim.diagnostic.severity.ERROR] = { enabled = true, icon = " " },
                [vim.diagnostic.severity.WARN] = { enabled = true, icon = " " },
                [vim.diagnostic.severity.INFO] = { enabled = true, icon = " " },
                [vim.diagnostic.severity.HINT] = { enabled = true, icon = " " },
              },
              gitsigns = {
                added = { enabled = true, icon = "+" },
                changed = { enabled = true, icon = "~" },
                deleted = { enabled = true, icon = "-" },
              },
            },
          })

          require("which-key").add({
            { "<A-[>", "<Cmd>BufferPrevious<CR>", opts, desc = "Go to previous tab" },
            { "<A-]>", "<Cmd>BufferNext<CR>", opts, desc = "Go to next tab" },

            { "<A-,>", "<Cmd>BufferMovePrevious<CR>", opts, desc = "Move tab left" },
            { "<A-.>", "<Cmd>BufferMoveNext<CR>", opts, desc = "Move tab right" },

            { "<A-1>", "<Cmd>BufferGoto 1<CR>", opts, desc = "Go to tab 1" },
            { "<A-2>", "<Cmd>BufferGoto 2<CR>", opts, desc = "Go to tab 2" },
            { "<A-3>", "<Cmd>BufferGoto 3<CR>", opts, desc = "Go to tab 3" },
            { "<A-4>", "<Cmd>BufferGoto 4<CR>", opts, desc = "Go to tab 4" },
            { "<A-5>", "<Cmd>BufferGoto 5<CR>", opts, desc = "Go to tab 5" },
            { "<A-6>", "<Cmd>BufferGoto 6<CR>", opts, desc = "Go to tab 6" },
            { "<A-7>", "<Cmd>BufferGoto 7<CR>", opts, desc = "Go to tab 7" },
            { "<A-8>", "<Cmd>BufferGoto 8<CR>", opts, desc = "Go to tab 8" },
            { "<A-9>", "<Cmd>BufferGoto 9<CR>", opts, desc = "Go to tab 9" },
            { "<A-0>", "<Cmd>BufferLast<CR>", opts, desc = "Go to last tab" },

            { "<A-p>", "<Cmd>BufferPin<CR>", opts, desc = "Pin tab" },
            { "<A-c>", "<Cmd>BufferClose<CR>", opts, desc = "Close tab" },

            { "<leader>t", group = "Tab" },

            { "<leader>ts", group = "Sort" },
            { "<leader>tsb", "<Cmd>BufferOrderByBufferNumber<CR>", opts, desc = "Sort by buffer number" },
            { "<leader>tsn", "<Cmd>BufferOrderByName<CR>", opts, desc = "Sort by name" },
            { "<leader>tsd", "<Cmd>BufferOrderByDirectory<CR>", opts, desc = "Sort by directory" },
            { "<leader>tsl", "<Cmd>BufferOrderByLanguage<CR>", opts, desc = "Sort by language" },
            { "<leader>tsw", "<Cmd>BufferOrderByWindowNumber<CR>", opts, desc = "Sort By window number" },

            { "<leader>to", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>", opts, desc = "Close all tabs but current or pinned" },
            { "<leader>tl", "<Cmd>BufferCloseBuffersLeft<CR>", opts, desc = "Close left other tabs" },
            { "<leader>tr", "<Cmd>BufferCloseBuffersRight<CR>", opts, desc = "Close right other tabs" },
          })
        END
      '';
    }
  ];
}
