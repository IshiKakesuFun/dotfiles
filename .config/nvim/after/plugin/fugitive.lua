--------------------------------------------------------------------------------
-- https://github.com/tpope/vim-fugitive
--------------------------------------------------------------------------------
local km = vim.api.nvim_set_keymap
km("n", "<leader>hn", "<cmd>Git restore --staged %<cr>", { noremap = true, silent = true })
