vim.g.loaded_matchparen = 1
vim.g.cursorhold_updatetime = 100

local o = vim.opt

-- vim.cmd("set exrc")
o.exrc = true
o.autochdir = false
o.updatetime = 50 -- [set updatetime=50] Faster completion
o.timeoutlen = 800 -- By default timeoutlen is 1000 ms

o.hidden = false -- [set hidden] Required to keep multiple buffers open multiple buffers
o.errorbells = false
o.visualbell = false

-- line numbers
o.relativenumber = true
o.number = true
vim.wo.number = true

-- encoding
vim.scriptencoding = "utf-8"
o.encoding = "utf-8"
o.fileencoding = "utf-8"
o.bomb = true

-- undo/swap
o.backup = false -- [set nobackup] This is recommended by coc, undotree
o.swapfile = false -- [set noswapfile] This is recommended by undotree

-- formating
-- Helpful related items:
--   1. :center, :left, :right
--   2. gw{motion} - Put cursor back after formatting motion.

o.formatoptions = o.formatoptions - {"o"} -- O and o, don't continue comments
o.formatoptions:append({"r"}) -- Add asterisks in block comments 

-- tabs & indentation
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.autoindent = true

-- line wrapping
o.wrap = false
o.breakindent = true
o.backspace = { "start", "eol", "indent" }
o.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
o.linebreak = true

-- folding
o.foldmethod = "marker"
o.foldlevel = 0
o.foldenable = true
o.modelines = 1

-- search settings
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.incsearch = true
o.inccommand = "split"
o.iskeyword:append("-") -- "-" is now part of the word, not a divider
o.shortmess:append("c") -- [+c] Don't pass messages to |ins-completion-menu|.
o.path:append { "**" } -- Finding files - Search down into subfolders
o.wildignore:append { "*/node_modules/*" }

-- Cursorline highlighting control
--  Only have it on in the active buffer
o.cursorline = true -- Highlight the current line
local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
	vim.api.nvim_create_autocmd(event, {
		group = group,
		pattern = pattern,
		callback = function()
			vim.opt_local.cursorline = value
			vim.opt_local.colorcolumn = value and "80,120" or ""
		end,
	})
end
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")

-- appearance
o.termguicolors = true
o.background = "dark"
o.cursorcolumn = false
o.colorcolumn = "80,120"
o.signcolumn = "yes"
o.list = true
local status, u = pcall(require, "kakesu.utils")
if status then
	o.listchars = u.serialize_options(ICON.LISTCHARS)
end
o.winblend = 0
o.wildoptions = "pum"
o.pumblend = 5
o.pumheight = 10 -- Makes popup menu smaller
o.laststatus = 2
o.cmdheight = 1 -- [set cmdheight=3] More space for displaying messages
o.scrolloff = 10 -- Make it so there are always ten lines below my cursor
o.sidescrolloff = 5
o.guifont = "JetBrainsMonoNL NFM:h12"
o.showcmd = true

-- clipboard
if IS_WIN then
	o.clipboard:prepend({ "unnamed", "unnamedplus" }) 
elseif IS_UNIX then
	o.clipboard:append({ "unnamedplus" }) 
end

-- split windows
o.splitright = true
o.splitbelow = true
