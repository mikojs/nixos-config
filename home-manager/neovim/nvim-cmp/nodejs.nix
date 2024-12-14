{ pkgs
, ...
}: {
  packages = with pkgs; [ typescript typescript-language-server vscode-langservers-extracted ];
  config = ''
    require('lspconfig').ts_ls.setup{
      capabilities = capabilities
    }

    require('lspconfig').eslint.setup{
      capabilities = capabilities
    }
  '';
}
