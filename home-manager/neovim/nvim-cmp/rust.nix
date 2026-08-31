{
  pkgs,
  ...
}:
{
  packages = with pkgs; [
    rust-analyzer
    clippy
  ];

  support = [
    "- `rust-analyzer`: Rust language server."
    "- `clippy`: The linter rust-analyzer runs as its `check` command."
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
    vim.lsp.enable("rust_analyzer")
  '';
}
