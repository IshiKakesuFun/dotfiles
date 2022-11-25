vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

vim.g.loaded_matchparen = 1
vim.g.cursorhold_updatetime = 100

local o = vim.opt

o.exrc = true
o.autochdir = false
o.updatetime = 50 -- [set updatetime=50] Faster completion
o.timeoutlen = 800 -- By default timeoutlen is 1000 ms

vim.cmd("set exrc")
o.hidden = false -- [set hidden] Required to keep multiple buffers open multiple buffers
o.errorbells = false
o.visualbell = false

-- line numbers
o.relativenumber = true
o.number = true

-- encoding
o.fileencoding = "utf-8"
o.bomb = true

-- undo/swap
o.backup = false -- [set nobackup] This is recommended by coc, undotree
o.swapfile = false -- [set noswapfile] This is recommended by undotree