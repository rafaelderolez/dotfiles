-- conform.lua
return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "oxfmt", "biome-check", stop_after_first = true },
        javascriptreact = { "oxfmt", "biome-check", stop_after_first = true },
        typescript = { "oxfmt", "biome-check", stop_after_first = true },
        typescriptreact = { "oxfmt", "biome-check", stop_after_first = true },
        json = { "oxfmt", "biome-check", stop_after_first = true },
        css = { "biome-check" },
      },
      formatters = {
        oxfmt = {
          condition = function(self, ctx)
            return vim.fs.find(".oxfmtrc.json", { path = ctx.dirname, upward = true })[1] ~= nil
          end,
        },
        ["biome-check"] = {
          condition = function(self, ctx)
            return vim.fs.find({ "biome.json", "biome.jsonc" }, { path = ctx.dirname, upward = true })[1] ~= nil
          end,
        },
      },
    },
  },
}
