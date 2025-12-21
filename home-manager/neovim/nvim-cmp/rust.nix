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
    vim.lsp.config("rust_analyzer", {
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
