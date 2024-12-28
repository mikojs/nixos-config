{
  pkgs,
  ...
}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = gitsigns-nvim;
      config = ''
        lua << END
          local gitsigns = require("gitsigns")

          gitsigns.setup({
            numhl = true,
            current_line_blame = true,
            current_line_blame_opts = {
              delay = 100,
            },
          })

          local next_git_hunk = function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gitsigns.nav_hunk("next")
            end
          end

          local prev_git_hunk = function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gitsigns.nav_hunk("prev")
            end
          end

          local stage_git_hunk = function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end
          local reset_git_hunk = function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end

          local diffthis = function()
            gitsigns.diffthis("~")
          end
          local blame_line = function()
            gitsigns.blame_line({ full = true })
          end

          require("which-key").add({
            { "]c", next_git_hunk, desc = "Next git hunk" },
            { "[c", prev_git_hunk, desc = "Previous git hunk" },

            { "<leader>g", group = "Git", mode = { "n", "v" } },
            { "<leader>gs", stage_git_hunk, desc = "Stage git hunk", mode = "v" },
            { "<leader>gr", reset_git_hunk, desc = "Reset git hunk", mode = "v" },

            { "<leader>gs", gitsigns.stage_hunk, desc = "Stage git hunk" },
            { "<leader>gr", gitsigns.reset_hunk, desc = "Reset git hunk" },
            { "<leader>gS", gitsigns.stage_buffer, desc = "Stage git buffer" },
            { "<leader>gu", gitsigns.undo_stage_hunk, desc = "Undo stage git hunk" },
            { "<leader>gR", gitsigns.reset_buffer, desc = "Reset git buffer" },
            { "<leader>gp", gitsigns.preview_hunk, desc = "Preview git hunk" },
            { "<leader>gd", gitsigns.diffthis, desc = "Diff this" },
            { "<leader>gD", diffthis, desc = "Diff this (cached)" },
            { "<leader>gb", blame_line, desc = "Blame line" },
            { "<leader>gt", gitsigns.toggle_deleted, desc = "Toggle deleted" },
          })
        END
      '';
    }
  ];
}
