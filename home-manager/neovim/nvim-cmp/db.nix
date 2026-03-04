{
  pkgs,
  ...
}:
{
  packages = with pkgs; [
    sql-language-server
    miko-db
  ];

  config = ''
    local db_sqlls_command = io.popen("db sqlls")
    local connections = vim.json.decode(db_sqlls_command:read("*a"))

    db_sqlls_command:close()
    vim.lsp.config("sqlls", {
      capabilities = capabilities,
      settings = {
        sqlLanguageServer = {
          connections = connections,
        },
      },
    })
    vim.lsp.enable('sqlls')
  '';
}
