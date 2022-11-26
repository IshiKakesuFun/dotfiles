--------------------------------------------------------------------------------
-- Global variables
--------------------------------------------------------------------------------
IS_UNIX = vim.fn.has("macunix")
IS_WIN = vim.fn.has("win32")
PATH_SEPARATOR = IS_WIN and "\\" or "/"

CONFIG_PATH = vim.fn.stdpath("config")
CONFIG_LUA = CONFIG_PATH .. PATH_SEPARATOR .. "lua"
DATA_PATH = vim.fn.stdpath("data")
CACHE_PATH = vim.fn.stdpath("cache")
VIMRUNTIME = vim.fn.expand("$VIMRUNTIME")
VIMRUNTIME_LUA = VIMRUNTIME .. PATH_SEPARATOR .. "lua"
USER = vim.fn.expand("$USERPROFILE")
APPDATA = vim.fn.expand("$APPDATA")
LOCALAPPDATA = vim.fn.expand("$LOCALAPPDATA")
DOCUMENTS = USER .. PATH_SEPARATOR .. "Documents"
REPOS = USER .. PATH_SEPARATOR .. "repos"

ICON = {
  branch = "", -- 0xea68
	ellipsis = "…", -- 0x2026
	skull = "💀", -- 0x1f480
  
  floppy = "", -- 0xf692
	lock = "", -- 0xf023
  star = "", -- 0xea6a

  plus_box = "", -- 0xf0fe
  pen_box = "", -- 0xf14b
  minus_box = "", -- 0xf146
  x_box = "", -- 0xf656
  star_box = "", -- 0xf882

  unix = "", -- 0xe712
  windows = "", -- 0xe70f
  apple = "", -- 0xe711

  bug = "", -- 0xf188
  exclamation = "", -- 0xf421
  icircle = "", -- 0xf41b
  bulb = "", -- 0xf400

  eol = "﬋", -- 0xfb0b;

  leftbar = "▎", -- 0x258e
  scrolldown = "", -- 0xf0dd
  scrollup = "", -- 0xf0de
  leftdashbar = "┆", -- 0x2506
}

--------------------------------------------------------------------------------
-- Icon groups
--------------------------------------------------------------------------------
ICON.LISTCHARS = {
  eol = ICON.eol,
  tab = "", -- 0xea9b,0xeaba,0xea9c; must be 2|3 chars
  trail = "▫", -- 0x25ab
  nbsp = "‿", -- 0x203f
}
ICON.DIFF = {
  added = ICON.plus_box,
  modified = ICON.pen_box,
  removed = ICON.minus_box,
}
ICON.OS = {
  unix = ICON.unix,
  dos = ICON.windows,
  mac = ICON.apple,
}
ICON.DIAGNOSTICS = {
  error = ICON.bug,
  warn = ICON.exclamation,
  info = ICON.icircle,
  hint = ICON.bulb,
}
ICON.cDIAGNOSTICS = {
  Error = ICON.bug,
  Warn = ICON.exclamation,
  Info = ICON.icircle,
  Hint = ICON.bulb,
}
ICON.SEPARATORS = {
  section = {
  	left = "", -- 0xe0bc
	  -- left = '', -- 0xe0b0
	  right = "", -- 0xe0ba
	  -- right = '', -- 0xe0b2
  },
	component= {
		left = "", -- 0xe0bd
	  -- left = '', -- 0xe0b1
		right = "", -- 0xe0bb
	  -- right = '', -- 0xe0b3
	},
}
ICON.GITSIGNS = {
  add = ICON.leftbar,
  change = ICON.leftbar,
  changedelete = ICON.leftbar,
  delete = ICON.scrolldown .. " ",
  topdelete = ICON.scrollup .. " ",
  untracked = ICON.leftdashbar .. " ",
}
