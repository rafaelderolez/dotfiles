return {
  "folke/flash.nvim",
  keys = {
    {
      "<CR>",
      function()
        require("flash").treesitter({
          actions = {
            ["<TAB>"] = "next",
            ["<S-TAB>"] = "prev",
          },
        })
      end,
      mode = { "n", "x", "o" },
    },
  },
}
