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
