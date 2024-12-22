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
          require('gitsigns').setup({
            numhl = true,
            current_line_blame = true,
            current_line_blame_opts = {
              delay = 100,
            },
            on_attach = function(bufnr)
              local gitsigns = require('gitsigns')

              local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
              end

              -- Navigation
              map('n', ']c', function()
                if vim.wo.diff then
                  vim.cmd.normal({']c', bang = true})
                else
                  gitsigns.nav_hunk('next')
                end
              end, { desc = 'Next git hunk' })

              map('n', '[c', function()
                if vim.wo.diff then
                  vim.cmd.normal({'[c', bang = true})
                else
                  gitsigns.nav_hunk('prev')
                end
              end, { desc = 'Previous git hunk' })

              require('which-key').add({
                { '<leader>g', group = 'Gitsigns' },
                { '<leader>gh', group = 'Hunk' },
                { '<leader>gt', group = 'Toggle' },
              })

              -- Actions
              map('n', '<leader>ghs', gitsigns.stage_hunk, { desc = 'Stage git hunk' })
              map('n', '<leader>ghr', gitsigns.reset_hunk, { desc = 'Reset git hunk' })
              map('v', '<leader>ghs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Stage git hunk' })
              map('v', '<leader>ghr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Reset git hunk' })
              map('n', '<leader>ghS', gitsigns.stage_buffer, { desc = 'Stage git buffer' })
              map('n', '<leader>ghu', gitsigns.undo_stage_hunk, { desc = 'Undo stage git hunk' })
              map('n', '<leader>ghR', gitsigns.reset_buffer, { desc = 'Reset git buffer' })
              map('n', '<leader>ghp', gitsigns.preview_hunk, { desc = 'Preview git hunk' })
              map('n', '<leader>ghb', function() gitsigns.blame_line{full=true} end, { desc = 'Blame line' })
              map('n', '<leader>ghd', gitsigns.diffthis, { desc = 'Diff this' })
              map('n', '<leader>ghD', function() gitsigns.diffthis('~') end, { desc = 'Diff this (cached)' })
              map('n', '<leader>gtd', gitsigns.toggle_deleted, { desc = 'Toggle deleted' })
            end
          })
        END
      '';
    }
  ];
}
