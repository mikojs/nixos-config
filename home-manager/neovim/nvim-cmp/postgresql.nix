{
  ...
}:
{
  config = ''
    require("lspconfig").sqlls.setup({
      capabilities = capabilities,
    })
  '';
}
