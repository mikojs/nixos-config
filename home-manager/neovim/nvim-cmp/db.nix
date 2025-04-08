{
  pkgs,
  ...
}:
{
  packages = with pkgs; [
    sqls
  ];

  plugins = with pkgs.vimPlugins; [
    sqls-nvim
  ];

  config = ''
    require("lspconfig").sqls.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        require('sqls').on_attach(client, bufnr)
      end,
    })
  '';
}
