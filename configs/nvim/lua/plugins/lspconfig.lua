local baseConfig = {
  updateImportsOnFileMove = { enabled = "always" },
  suggest = {
    completeFunctionCalls = true,
  },
  preferences = {
    quoteStyle = "double",
    importModuleSpecifier = "non-relative",
    importModuleSpecifierEnding = "auto",
    useAliasesForRenames = false,
  },
}

return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      vtsls = {
        settings = {
          vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
          javascript = baseConfig,
          typescript = baseConfig,
        },
      },
    },
  },
}
