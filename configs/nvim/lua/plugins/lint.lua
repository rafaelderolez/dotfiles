-- lint.lua
return {
  -- oxlint: conditional on config file
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        javascript = { "oxlint" },
        javascriptreact = { "oxlint" },
        typescript = { "oxlint" },
        typescriptreact = { "oxlint" },
      },
      linters = {
        oxlint = {
          condition = function(ctx)
            return vim.fs.find({ ".oxlintrc.json", "oxlint.config.ts" }, { path = ctx.filename, upward = true })[1] ~= nil
          end,
        },
      },
    },
  },
  -- eslint LSP: only start when eslint config exists in project
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        eslint = {
          root_dir = require("lspconfig.util").root_pattern(
            "eslint.config.js", "eslint.config.mjs", "eslint.config.cjs",
            "eslint.config.ts", "eslint.config.mts", "eslint.config.cts",
            ".eslintrc", ".eslintrc.js", ".eslintrc.cjs",
            ".eslintrc.json", ".eslintrc.yaml", ".eslintrc.yml"
          ),
        },
      },
    },
  },
}
