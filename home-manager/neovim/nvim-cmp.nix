{ pkgs
, languages
, ...
}: {
  home.packages = with pkgs; with builtins; [ ] ++ (if elem "nix" languages then [ nil ] else [ ]);

  programs.neovim.plugins = with pkgs.vimPlugins; with builtins; [
    vim-vsnip
    cmp-vsnip

    nvim-lspconfig
    cmp-nvim-lsp

    cmp-buffer
    cmp-path
    cmp-cmdline

    {
      plugin = nvim-cmp;
      config = ''
        lua <<EOF
          local cmp = require('cmp')

          cmp.setup({
            sources = cmp.config.sources({
              { name = 'nvim_lsp' },
              { name = 'vsnip' },
              { name = 'path' },
              { name = 'nvim_treesitter' },
            }, {
              { name = 'buffer' },
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
            mapping = cmp.mapping.preset.insert({
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }),
            })
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

          local capabilities = require('cmp_nvim_lsp').default_capabilities()
      '' +
      (if elem "nix" languages then ''
        require('lspconfig').nil_ls.setup {
          capabilities = capabilities
        }
      '' else "") +
      ''
        EOF
      '';
    }
  ];
}
