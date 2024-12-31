{
  pkgs,
  ...
}:
{
  packages = with pkgs; [
    sqls
  ];

  config = ''
    require("lspconfig").sqls.setup({
      capabilities = capabilities,
    })
  '';
}
