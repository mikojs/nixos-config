{
  pkgs,
  ...
}:
{
  packages = with pkgs; [
    rust-analyzer
  ];

  config = ''
    require("lspconfig").rust_analyzer.setup({
      capabilities = capabilities,
    })
  '';
}
