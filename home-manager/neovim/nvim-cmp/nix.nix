{ pkgs
, ...
}: {
  packages = with pkgs; [ nil ];
  config = ''
    require('lspconfig').nil_ls.setup {
      capabilities = capabilities
    }
  '';
}
