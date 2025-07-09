{
  ...
}:
{
  init = ''
    require("conform").formatters.prettier = {
      command = function(self, bufnr)
        local util = require("conform.util")
        local fs = require("conform.fs")
        local cmd = util.find_executable({ ".yarn/sdks/prettier/bin/prettier.cjs" }, "")(self, bufnr)

        if cmd ~= "" then
          return cmd
        end

        return util.from_node_modules(fs.is_windows and "prettier.cmd" or "prettier")(self, bufnr)
      end,
    }
  '';

  formatter = ''
    javascript = { "prettier" },
    typescript = { "prettier" }
  '';
}
