{
  pkgs,
  ...
}:
{
  packages = with pkgs; [
    typescript
    typescript-language-server
    vscode-langservers-extracted
  ];

  config = ''
    vim.lsp.config("ts_ls", {
      capabilities = capabilities,
    })

    vim.lsp.config("eslint", {
      capabilities = capabilities,
    })
  '';
}
