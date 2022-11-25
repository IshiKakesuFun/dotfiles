--------------------------------------------------------------------------------
-- https://github.com/unblevable/quick-scope
--------------------------------------------------------------------------------
-- Start plugin as enabled
vim.g.qs_enable = 1

-- Trigger a highlight in the appropriate direction when pressing these keys:
vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }

-- Turn off this plugin when the length of line is longer than
vim.g.qs_max_chars = 150

vim.g.qs_delay = 0

vim.g.qs_buftype_blacklist = { "terminal", "nofile" }
vim.g.qs_filetype_blacklist = { "dashboard", "startify" }
vim.g.qs_lazy_highlight = 0

local group = vim.api.nvim_create_augroup("qs_colors", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = group,
  pattern = "*",
  command = "highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline",
})
vim.api.nvim_create_autocmd("ColorScheme", {
  group = group,
  pattern = "*",
  command = "highlight QuickScopeSecondary guifg='#0fffff' gui=underline ctermfg=81 cterm=underline",
})