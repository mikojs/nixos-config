{
  pkgs,
  languages,
  ...
}:
let
  languagesConfig =
    with builtins;
    map (
      l:
      import ./${l.language}.nix {
        inherit pkgs;
      }
    ) (filter (l: pathExists ./${l.language}.nix) languages);
in
{
  home.packages = with builtins; foldl' (result: l: result ++ l.packages) [ ] languagesConfig;

  programs.neovim.plugins =
    with pkgs.vimPlugins;
    with builtins;
    [
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
            local cmp = require("cmp")

            cmp.setup({
              sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "vsnip" },
                { name = "path" },
                { name = "nvim_treesitter" },
              }, {
                { name = "buffer" },
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
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  elseif vim.fn.pumvisible() == 1 then
                    vim.fn.feedkeys("\n", "n")
                  else
                    fallback()
                  end
                end, { "i", "s" }),
              }),
              formatting = {
                format = function(entry, item)
                  local icons = {
                    Array         = " ",
                    Boolean       = "󰨙 ",
                    Class         = " ",
                    Codeium       = "󰘦 ",
                    Color         = " ",
                    Control       = " ",
                    Collapsed     = " ",
                    Constant      = "󰏿 ",
                    Constructor   = " ",
                    Copilot       = " ",
                    Enum          = " ",
                    EnumMember    = " ",
                    Event         = " ",
                    Field         = " ",
                    File          = " ",
                    Folder        = " ",
                    Function      = "󰊕 ",
                    Interface     = " ",
                    Key           = " ",
                    Keyword       = " ",
                    Method        = "󰊕 ",
                    Module        = " ",
                    Namespace     = "󰦮 ",
                    Null          = " ",
                    Number        = "󰎠 ",
                    Object        = " ",
                    Operator      = " ",
                    Package       = " ",
                    Property      = " ",
                    Reference     = " ",
                    Snippet       = " ",
                    String        = " ",
                    Struct        = "󰆼 ",
                    Supermaven    = " ",
                    TabNine       = "󰏚 ",
                    Text          = " ",
                    TypeParameter = " ",
                    Unit          = " ",
                    Value         = " ",
                    Variable      = "󰀫 ",
                  };

                  if icons[item.kind] then
                    item.kind = icons[item.kind] .. item.kind
                  end

                  local widths = {
                    abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
                    menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
                  }

                  for key, width in pairs(widths) do
                    if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
                      item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
                    end
                  end

                  return item
                end,
              },
            })

            cmp.setup.cmdline({ "/", "?" }, {
              mapping = cmp.mapping.preset.cmdline(),
              sources = {
                { name = "buffer" },
              },
            })

            cmp.setup.cmdline(":", {
              mapping = cmp.mapping.preset.cmdline(),
              sources = cmp.config.sources({
                { name = "path" },
              }, {
                { name = "cmdline" },
              }),
              matching = { disallow_symbol_nonprefix_matching = false },
            })

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            ${(with builtins; foldl' (result: l: result + l.config) "" languagesConfig)}
          EOF
        '';
      }
    ];
}
