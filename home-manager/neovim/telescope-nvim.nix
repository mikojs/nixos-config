{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    ripgrep
    fd
  ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = telescope-nvim;
      config = ''
        lua << END
          local builtin = require('telescope.builtin')
          local wk = require('which-key')

          wk.add({
            { '<leader>t', group = 'Telescope' },
            { '<leader>tf', builtin.find_files, desc = 'Telescope find files' },
            { '<leader>tl', builtin.live_grep, desc = 'Telescope live grep' },
            { '<leader>tb', builtin.buffers, desc = 'Telescope buffers' },
            { '<leader>th', builtin.help_tags, desc = 'Telescope help tags' },
            { '<leader>tk', builtin.keymaps, desc = 'Telescope keymaps' },

            { '<leader>tg', group = 'Telescope git' },
            { '<leader>tgs', builtin.git_status, desc = 'Telescope git status' },
            { '<leader>tgh', builtin.git_stash, desc = 'Telescope git stash' },
            { '<leader>tgc', builtin.git_commits, desc = 'Telescope git commit' },
          })
        END
      '';
    }
  ];
}
