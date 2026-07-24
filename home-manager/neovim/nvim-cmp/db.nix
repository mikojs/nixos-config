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
        sqlite = "sqlite3",
        sqlserver = "mssql",
      }
      local found = false

      for i, conn in ipairs(sqls_connections) do
        if conn.alias == alias then
          sqls_connections[i] = { alias = alias, driver = driver_map[scheme] or scheme, dataSourceName = url }
          found = true

          break
        end
      end

      if not found then
        table.insert(sqls_connections, { alias = alias, driver = driver_map[scheme] or scheme, dataSourceName = url })
      end

      vim.lsp.config("sqls", {
        capabilities = capabilities,
        settings = { sqls = { connections = sqls_connections } },
      })
      vim.cmd("LspRestart sqls")
    end, { nargs = "+" })

    vim.lsp.enable("sqls")
  '';
}
