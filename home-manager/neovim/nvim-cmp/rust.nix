{
  pkgs,
  ...
}:
{
  packages = with pkgs; [
    rust-analyzer
    clippy
  ];

  config = ''
    require("lspconfig").rust_analyzer.setup({
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          check = {
            command = "clippy",
          },
        },
      },
    })
  '';
}
