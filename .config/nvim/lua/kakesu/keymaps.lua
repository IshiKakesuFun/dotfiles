-- set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local km = vim.api.nvim_set_keymap

local cOpts = { noremap = true, silent = true }
local nOpts = { noremap = true, silent = true }
local nsOpts = { noremap = true, silent = false }
local vOpts = { noremap = true, silent = true }
local vsOpts = { noremap = true, silent = false }
local iOpts = { noremap = true, silent = true }

--------------------------------------------------------------------------------
-- COMMAND
--------------------------------------------------------------------------------

-- for to slow shift release
km("c", "W<CR>", "w<CR>", cOpts)
km("c", "Q<CR>", "q<CR>", cOpts)

--------------------------------------------------------------------------------
-- NORMAL
--------------------------------------------------------------------------------

-- remap leader keys to noop
km("n", " ", "", nOpts)
km("n", "\\", "", nOpts)

-- window management
km("n", "sv", "<cmd>vsplit<CR><C-w>l", nOpts) -- split window vertically, move to new
km("n", "ss", "<cmd>split<CR><C-w>j", nOpts) -- split window horizontally, move to new
km("n", "se", "<C-w>=", nOpts) -- make split windows equal width & height
km("n", "sc", ":close<CR>", nOpts) -- close current split window
km("n", "sx", "<C-w>x", nOpts) -- exchange splited windows
km("n", "sw", "<C-w>w", nOpts) -- switch to next window; or use with number {winnr}sw

-- Smart way to move between windows
km("n", "sh", "<C-w>h", nOpts)
km("n", "sj", "<C-w>j", nOpts)
km("n", "sk", "<C-w>k", nOpts)
km("n", "sl", "<C-w>l", nOpts)
km("n", "s<Left>", "<C-w>h", nOpts)
km("n", "s<Down>", "<C-w>j", nOpts)
km("n", "s<Up>", "<C-w>k", nOpts)
km("n", "s<Right>", "<C-w>l", nOpts)

-- tabs manegement
km("n", "<C-t>e", ":tabedit<CR>", nOpts)

-- Smart way to move between tabs
-- { '<A-h>', 'gT' },
-- { '<A-l>', 'gt' },

-- Resize split
km("n", "<C-Up>", ":resize +2<CR>", nOpts)
km("n", "<C-Down>", ":resize -2<CR>", nOpts)
km("n", "<C-Left>", ":vertical resize +2<CR>", nOpts)
km("n", "<C-Right>", ":vertical resize -2<CR>", nOpts)

-- Move across wrapped lines like regular lines
km("n", "0", "^", nOpts)
km("n", "^", "0", nOpts)

-- old windows habbits
km("n", "<C-a>", "ggVG", nOpts) -- select all
km("n", "<C-s>", "<cmd>w<CR>", nOpts) -- save changes 

-- capy all messages to clipboard
km("n", "<leader>cm", "<cmd>let @*=execute('messages')<cr>", nOpts)

-- delete single character without copying into register
km("n", "x", '"_x', nOpts)

-- pwd
km("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>", nOpts)
km("n", "<leader>lcd", ":lcd %:p:h<CR>:pwd<CR>", nOpts)
km("n", "<leader>tcd", ":tcd %:p:h<CR>:pwd<CR>", nOpts)

-- increment/decrement
km("n", "+", "<C-a>", nOpts)
km("n", "-", "<C-x>", nOpts)

-- conversion unicode
km("n", "<leader>2c", ':lua require("kakesu.utils").replace_hex_to_char()<CR>', nOpts)
km("n", "<leader>2x", ':lua require("kakesu.utils").replace_char_to_hex()<CR>', nOpts)
km("n", "<leader>2yc", ':lua require("kakesu.utils").yank_hex_to_char()<CR>', nOpts)
km("n", "<leader>2yx", ':lua require("kakesu.utils").yank_char_to_hex()<CR>', nOpts)

-- km("n", "<Leader>e", ":NvimTreeToggle<CR>", nOpts) -- TODO move to after/plugin

--------------------------------------------------------------------------------
-- NORMAL NON-SILENT
--------------------------------------------------------------------------------

-- source lua files
km("n", "<leader>.<CR>", ":luafile " .. CONFIG_PATH .. "\\init.lua<CR>", nsOpts)
km("n", "<leader><CR>", ":luafile %<CR>", nsOpts)
-- greatest remap ever
km("n", "<leader>y", '"+y', nsOpts)
km("n", "<leader>Y", 'ggVG"+y', nsOpts)
km("n", "<leader>d", '"_d', nsOpts)
km("n", "<leader>D", '"_D', nsOpts)
-- wipe trailing blanks
km("n", "<leader>ft", "<cmd>%s/\\s\\+$//g<CR>", nsOpts)

--------------------------------------------------------------------------------
-- VISUAL
--------------------------------------------------------------------------------

-- move selected line(s)
km("v", "K", ":move '<-2<CR>gv-gv", vOpts)
km("v", "J", ":move '>+1<CR>gv-gv", vOpts)

--------------------------------------------------------------------------------
-- VISUAL NON-SILENT
--------------------------------------------------------------------------------

-- greatest remap ever
km("v", "<leader>p", '"_dP', vsOpts)
km("v", "<leader>y", '"+y', vsOpts)
km("v", "<leader>d", '"_d', vsOpts)
km("v", "<leader>ft", "<cmd>'<,'>s/\\s\\+$//g<CR>", vsOpts)

--------------------------------------------------------------------------------
-- INSERT
--------------------------------------------------------------------------------

-- Smart way to move between tabs
-- { '<A-h>', [[<C-\><C-n>gT]] },
-- { '<A-l>', [[<C-\><C-n>gt]] },
-- insert special carachters
-- { '<C-b>', '<C-k>' },

-- use jk to exit insert mode
km("i", "jk", "<ESC>", iOpts)
