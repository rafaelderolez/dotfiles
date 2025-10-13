return {
  "nvim-lualine/lualine.nvim",
  optional = true,
  event = "VeryLazy",
  opts = function(_, opts)
    local icons = {
      Error = { " ", "DiagnosticError" },
      Inactive = { " ", "MsgArea" },
      Warning = { " ", "DiagnosticWarn" },
      Normal = { LazyVim.config.icons.kinds.Copilot, "Special" },
    }
    table.insert(opts.sections.lualine_x, 2, {
      function()
        local status = require("sidekick.status").get()
        return status and vim.tbl_get(icons, status.kind, 1)
      end,
      cond = function()
        return require("sidekick.status").get() ~= nil
      end,
      color = function()
        local status = require("sidekick.status").get()
        local hl = status and (status.busy and "DiagnosticWarn" or vim.tbl_get(icons, status.kind, 2))
        return { fg = Snacks.util.color(hl) }
      end,
    })
  end,
}
