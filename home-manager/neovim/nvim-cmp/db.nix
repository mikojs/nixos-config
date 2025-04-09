{
  pkgs,
  ...
}:
{
  packages = with pkgs; [
    sqls
    miko-db
  ];

  plugins = with pkgs.vimPlugins; [
    sqls-nvim
  ];

  config = ''
    local db_sqls_command = io.popen("db sqls")
    local connections = vim.json.decode(db_sqls_command:read("*a"))

    db_sqls_command:close()
    require("lspconfig").sqls.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        require('sqls').on_attach(client, bufnr)
      end,
      settings = {
        sqls = {
          connections= connections,
        },
      },
    })
  '';
}
