---@module "lazy"
---@type LazySpec
return {
  {
    "mikavilpas/yazi.nvim",
    lazy = false,
    opts = {
      integrations = {
        picker_add_copy_relative_path_action = "snacks.picker",
        -- 👆🏻 add this
        resolve_relative_path_implementation = function(args, get_relative_path)
          -- By default, the path is resolved from the file/dir yazi was focused on
          -- when it was opened. Here, we change it to resolve the path from
          -- Neovim's current working directory (cwd) to the target_file.
          local cwd = vim.fn.getcwd()
          local path = get_relative_path({
            selected_file = args.selected_file,
            source_dir = cwd,
          })
          return path
        end,
      },
    },
    keys = {
      {
        "<leader>e",
        "<cmd>Yazi<CR>",
      },
      {
        "<leader>E",
        "<cmd>Yazi cwd<CR>",
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        enabled = true,
        keys = {
          ["<leader>e"] = nil,
          ["<leader>E"] = nil,
        },
      },
      picker = {
        win = {
          input = {
            keys = {
              ["<C-y>"] = { "yazi_copy_relative_path", mode = { "n", "i" } },
              -- 👆🏻 add this and customize the keybinding to suit your needs
            },
          },
        },
      },
    },
  },
}
