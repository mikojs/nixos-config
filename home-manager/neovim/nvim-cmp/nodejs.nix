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

  support = [
    "- `typescript`: Provides `tsc`, which the TypeScript language server needs."
    "- `typescript-language-server`: TypeScript and JavaScript language server."
    "- `vscode-langservers-extracted`: Provides the `eslint` language server."
  ];

  # FIXME: https://github.com/neovim/nvim-lspconfig/issues/3858
  config = ''
    vim.lsp.config("ts_ls", {
      capabilities = capabilities,
    })
    vim.lsp.enable("ts_ls")

    local yarn_lib = vim.fs.find('.yarn/sdks/eslint', { upward = true })[1]
    local nodePath = ""

    if yarn_lib then
      nodePath = ".yarn/sdks"
    end

    vim.lsp.config("eslint", {
      capabilities = capabilities,
      settings = {
        nodePath = nodePath,
      },
    })
    vim.lsp.enable("eslint")
  '';
}
