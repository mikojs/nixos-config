{ pkgs
, ...
}: with pkgs.vimPlugins; ''
  {
    dir = "${nvim-cmp}",
    name = "nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      { dir = "${cmp-nvim-lsp}", name = "cmp-nvim-lsp" },
      { dir = "${cmp-path}", name = "cmp-path" },
      { dir = "${cmp-buffer}", name = "cmp-buffer" },
      { dir = "${cmp-cmdline}", name = "cmp-cmdline" },
    },
    config = function ()
      local cmp = require('cmp')

      cmp.setup({
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'path' },
        }),
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({}),
      })

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })
    end,
  },
''
