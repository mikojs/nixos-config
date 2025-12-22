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
    vim.lsp.enable("ts_ls")

    vim.lsp.config("eslint", {
      capabilities = capabilities,
    })
    vim.lsp.enable("eslint")
  '';
}
