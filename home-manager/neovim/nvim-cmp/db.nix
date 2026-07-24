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

        // Load a database connection dynamically
        // Usage: SqlsLoad <alias> <shell-command-that-outputs-connection-url>
        // Example: SqlsLoad mydb echo postgresql://localhost/mydb
        :SqlsLoad <alias> <cmd...>
        ```
      '';
    }
  ];

  packages = with pkgs; [
    sqls
  ];

  plugins = with pkgs.vimPlugins; [
    sqls-nvim
  ];

  config = ''
    local sqls_connections = {}

    vim.api.nvim_create_user_command("SqlsLoad", function(opts)
      local alias = opts.fargs[1]
      local cmd = table.concat(opts.fargs, " ", 2)
      local url = vim.fn.system(cmd)

      if vim.v.shell_error ~= 0 then
        vim.notify("SqlsLoad failed: " .. url, vim.log.levels.ERROR)

        return
      end

      url = url:gsub("%s+$", "")

      local scheme = url:match("^(%w+)://")
      local driver_map = {
        postgresql = "postgresql",
        postgres = "postgresql",
        mysql = "mysql",
        sqlserver = "mssql",
      }
      local found = false

      for i, conn in ipairs(sqls_connections) do
        if conn.alias == alias then
          sqls_connections[i] = { alias = alias, driver = driver_map[scheme] or "sqlite3", dataSourceName = url }
          found = true

          break
        end
      end

      if not found then
        table.insert(sqls_connections, { alias = alias, driver = driver_map[scheme] or "sqlite3", dataSourceName = url })
      end

      vim.lsp.config("sqls", {
        capabilities = capabilities,
        settings = { sqls = { connections = sqls_connections } },
      })

      local clients = vim.lsp.get_clients({ name = "sqls" })

      if #clients > 0 then
        for _, client in ipairs(clients) do
          client:notify("workspace/didChangeConfiguration", {
            settings = { sqls = { connections = sqls_connections } },
          })
        end
      else
        vim.lsp.enable("sqls")
      end
    end, { nargs = "+" })

    vim.lsp.enable("sqls")
  '';
}
