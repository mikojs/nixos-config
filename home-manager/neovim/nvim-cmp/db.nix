{
  pkgs,
  miko,
  ...
}:
{
  file = miko.getDocs [
    {
      filePath = "neovim/sqls-nvim";
      docs = ''
        # sqls.nvim

        A neovim plugin for SQL.

        [Repository](https://github.com/nanotee/sqls.nvim)

        ```nvim
        // Only in .sql files
        :Sqls...
        ```
      '';
    }
  ];

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
    vim.lsp.config("sqls", {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        require('sqls').on_attach(client, bufnr)
      end,
      settings = {
        sqls = {
          connections = connections,
        },
      },
    })
    vim.lsp.enable("sqls")
  '';
}
