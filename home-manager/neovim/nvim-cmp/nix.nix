{
  pkgs,
  ...
}:
{
  packages = with pkgs; [ nil ];

  support = [ "- `nil`: Nix language server." ];

  config = ''
    vim.lsp.config("nil_ls", {
      capabilities = capabilities,
    })
    vim.lsp.enable("nil_ls")
  '';
}
