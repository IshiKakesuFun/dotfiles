--------------------------------------------------------------------------------
-- https://github.com/nvim-lualine/lualine.nvim
--------------------------------------------------------------------------------
-- import plugin safely
local status, lualine = pcall(require, "lualine")
if not status then
  return
end

-- get lualine theme
if not DEFAULT_COLOR_THEME then
  DEFAULT_COLOR_THEME = "gruvbox"
  vim.cmd("colorscheme " .. DEFAULT_COLOR_THEME)
end
local lualine_theme = require("lualine.themes." .. vim.g.colors_name)

local mode = {
  "mode",
  upper = false,
}
local branch = {
  "branch",
  icon = ICON.branch, -- 0xea68
}
local diff = {
  "diff",
  -- Displays a colored diff status if set to true
  colored = true,
  -- Changes the symbols used by the diff.
  symbols = ICON.DIFF,
}
local filename = {
  "filename",
  file_status = true,
  -- Display new file status (new file means no write after created)
  -- default: false
  newfile_status = true,
  -- 0: Just the filename
  -- 1: Relative path
  -- 2: Absolute path
  -- 3: Absolute path, with tilde as the home directory
  path = 0,
  symbols = {
    -- Text to show when the file is modified.
    -- default: "[+]"
    modified = ICON.floppy,
    -- Text to show when the file is non-modifiable or readonly.
    -- default: "[-]"
    readonly = ICON.lock,
    -- Text to show for unnamed buffers.
    -- default: "[No Name]"
    unnamed = "[no name]",
    -- Text to show for new created file before first writting
    -- default: "[New]"
    newfile = ICON.star,
  },
}
local filenamePath = {
  "filename",
  file_status = true,
  path = 1,
  symbols = {
    -- Text to show when the file is modified.
    -- default: "[+]"
    modified = ICON.floppy,
    -- Text to show when the file is non-modifiable or readonly.
    -- default: "[-]"
    readonly = ICON.lock,
    -- Text to show for unnamed buffers.
    -- default: "[No Name]"
    unnamed = "[no name]",
    -- Text to show for new created file before first writting
    -- default: "[New]"
    newfile = ICON.star,
  },
}
local tabs = {
  "tabs",
  -- 0: Shows tab_nr
  -- 1: Shows tab_name
  -- 2: Shows tab_nr + tab_name
  mode = 2,
}
local windows = {
  "windows",
  show_filename_only = true,
  show_modified_status = true,
  -- 0: Shows window name
  -- 1: Shows window index
  -- 2: Shows window name + window index
  mode = 2,
}

local filetype = { "filetype", icon_only = false }
local fileformat = {
  "fileformat",
  symbols = ICON.OS,
}
local diagnostics = {
  "diagnostics",
  -- Table of diagnostic sources, available sources are:
  --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
  -- or a function that returns a table as such:
  --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
  sources = {
    -- "nvim_lsp",
    "nvim_diagnostic",
  },
  -- Displays diagnostics for the defined severity types
  sections = { "error", "warn", "info", "hint" },
  symbols = ICON.DIAGNOSTICS,
  colored = true, -- Displays diagnostics status in color if set to true.
  update_in_insert = false, -- Update diagnostics in insert mode.
  always_visible = false, -- Show diagnostics even if there are none.
}

-- call plugin setup
lualine.setup({
  options = {
    globalstatus = false,
    icons_enabled = true,
    -- theme = "auto",
    theme = lualine_theme,
    section_separators = ICON.SEPARATORS.section,
    component_separators = ICON.SEPARATORS.component,
  },
  extensions = {
    "fugitive",
    "fzf",
    -- "nvim-tree",
    -- "quickfix",
    -- "toggleterm"
  },
  tabline = {
    lualine_a = {},
    lualine_b = { windows },
    lualine_c = {},
    lualine_x = { lsp_progress },
    lualine_y = {},
    lualine_z = { tabs },
  },
  sections = {
    lualine_a = { mode, branch },
    lualine_b = { filename },
    lualine_c = { diff },
    lualine_x = { diagnostics },
    lualine_y = { "encoding", fileformat, filetype },
    lualine_z = { "progress", "location", "vim.api.nvim_win_get_number(0)" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { filenamePath },
    lualine_x = { "location", "vim.api.nvim_win_get_number(0)" },
    lualine_y = {},
    lualine_z = {},
  },
})

local km = vim.keymap.set
km("n", "\\t", function()
  local name = vim.fn.input("rename tab " .. vim.api.nvim_tabpage_get_number(0) .. ": ")
  vim.cmd("LualineRenameTab " .. name)
end)
