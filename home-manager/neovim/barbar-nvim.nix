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
          local wk = require('which-key')
          local opts = { noremap = true, silent = true }

          wk.add({
            { '<A-[>', '<Cmd>BufferPrevious<CR>', opts },
            { '<A-]>', '<Cmd>BufferNext<CR>', opts },

            { '<A-,>', '<Cmd>BufferMovePrevious<CR>', opts },
            { '<A-.>', '<Cmd>BufferMoveNext<CR>', opts },

            { '<A-1>', '<Cmd>BufferGoto 1<CR>', opts },
            { '<A-2>', '<Cmd>BufferGoto 2<CR>', opts },
            { '<A-3>', '<Cmd>BufferGoto 3<CR>', opts },
            { '<A-4>', '<Cmd>BufferGoto 4<CR>', opts },
            { '<A-5>', '<Cmd>BufferGoto 5<CR>', opts },
            { '<A-6>', '<Cmd>BufferGoto 6<CR>', opts },
            { '<A-7>', '<Cmd>BufferGoto 7<CR>', opts },
            { '<A-8>', '<Cmd>BufferGoto 8<CR>', opts },
            { '<A-9>', '<Cmd>BufferGoto 9<CR>', opts },
            { '<A-0>', '<Cmd>BufferLast<CR>', opts },

            { '<A-p>', '<Cmd>BufferPin<CR>', opts },
            { '<A-c>', '<Cmd>BufferClose<CR>', opts },

            { '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts },
            { '<Space>bn', '<Cmd>BufferOrderByName<CR>', opts },
            { '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts },
            { '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts },
            { '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts },
          })
        END
      '';
    }
  ];
}
