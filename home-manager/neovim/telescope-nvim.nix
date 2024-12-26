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
            { '<leader>T', group = 'Telescope' },
            { '<leader>Tf', builtin.find_files, desc = 'Telescope find files' },
            { '<leader>Tl', builtin.live_grep, desc = 'Telescope live grep' },
            { '<leader>Tb', builtin.buffers, desc = 'Telescope buffers' },
            { '<leader>Th', builtin.help_tags, desc = 'Telescope help tags' },
            { '<leader>Tk', builtin.keymaps, desc = 'Telescope keymaps' },

            { '<leader>Tg', group = 'Telescope git' },
            { '<leader>Tgs', builtin.git_status, desc = 'Telescope git status' },
            { '<leader>Tgh', builtin.git_stash, desc = 'Telescope git stash' },
            { '<leader>Tgc', builtin.git_commits, desc = 'Telescope git commit' },
          })
        END
      '';
    }
  ];
}
