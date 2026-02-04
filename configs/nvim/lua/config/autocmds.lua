-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Copied from @fatih: https://github.com/fatih/dotfiles/blob/main/init.lua#L988-L1027
-- OSC 7: Report working directory to terminal (for Ghostty split inheritance)
-- https://github.com/neovim/neovim/issues/21771
local function osc7_notify()
  local cwd = vim.fn.getcwd()
  local hostname = vim.fn.hostname()
  local osc7 = string.format("\027]7;file://%s%s\027\\", hostname, cwd)
  vim.fn.chansend(vim.v.stderr, osc7)
end

local osc7_group = vim.api.nvim_create_augroup("osc7", { clear = true })

-- Send on directory change
vim.api.nvim_create_autocmd("DirChanged", {
  group = osc7_group,
  pattern = { "*" },
  callback = osc7_notify,
})

-- Send on buffer enter (autochdir may change dir without firing DirChanged)
vim.api.nvim_create_autocmd("BufEnter", {
  group = osc7_group,
  pattern = { "*" },
  callback = osc7_notify,
})

-- Send on Neovim startup
vim.api.nvim_create_autocmd("VimEnter", {
  group = osc7_group,
  pattern = { "*" },
  callback = osc7_notify,
})

-- Clear on exit so terminal falls back to shell's directory
vim.api.nvim_create_autocmd("VimLeave", {
  group = osc7_group,
  pattern = { "*" },
  callback = function()
    vim.fn.chansend(vim.v.stderr, "\027]7;\027\\")
  end,
})
