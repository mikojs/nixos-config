{
  pkgs,
  ...
}:
{
  packages = with pkgs; [ nil ];

  config = ''
    vim.lsp.config("nil_ls", {
      capabilities = capabilities,
    })
  '';
}
