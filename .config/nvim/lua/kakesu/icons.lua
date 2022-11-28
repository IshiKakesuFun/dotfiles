--------------------------------------------------------------------------------
-- Global icon variables
--------------------------------------------------------------------------------
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

  eol = "﬋", -- 0xfb0b
  bol = "﬌", -- 0xfb0c

  leftbar = "▎", -- 0x258e
  scrolldown = "", -- 0xf0dd
  scrollup = "", -- 0xf0de
  leftdashbar = "┆", -- 0x2506

  text = "", -- 0xe612
  textt = "", -- 0xf77e
  cude = "", -- 0xf6a6
  func = "", -- 0xf794
  settings = "", -- 0xf423
  property = "ﰠ", -- 0xfc20
  field = "", -- 0xe624
  alfa = "", -- 0xf52a
  class = "ﴯ", -- 0xfd2f
  interface = "", -- 0xf0e8
  -- interface = "ﰮ", -- 0xfc2e
  module = "", -- 0xf487
  unit = "塞", -- 0xf96c
  -- unit = "", -- 0xf475
  value = "", -- 0xf89f
  sort = "", -- 0xf15d
  key = "", -- 0xf80a
  types = "", -- 0xf44f
  list = "", -- 0xf0ca
  palette = "", -- 0xf8d7
  file = "", -- 0xf718
  -- file = "", -- 0xf15b
  -- reference = "", -- 0xf706
  reference = "", -- 0xf690
  folder = "", -- 0xf74a
  folderopen = "", -- 0xf115
  pi = "", -- 0xf8fe
  -- pi = "", -- 0xe22c
  tree = "פּ", -- 0xfb44
  event = "", -- 0xf0e7
  plusminus = "", -- 0xf694
  lambda = "ﬦ", -- 0xfb26
}

--------------------------------------------------------------------------------
-- Global icon groups
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
  component = {
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
ICON.CMP = {
  Text = ICON.text,
  Method = ICON.cube,
  Function = ICON.func,
  Constructor = ICON.settings,
  Field = ICON.field,
  Variable = ICON.alfa,
  Class = ICON.class,
  Interface = ICON.interface,
  Module = ICON.module,
  Property = ICON.property,
  Unit = ICON.unit,
  Value = ICON.value,
  Enum = ICON.list,
  Keyword = ICON.key,
  Snippet = ICON.bol,
  Color = ICON.palette,
  File = ICON.file,
  Reference = ICON.reference,
  Folder = ICON.folder,
  EnumMember = ICON.sort,
  Constant = ICON.pi,
  Struct = ICON.tree,
  Event = ICON.event,
  Operator = ICON.lambda,
  TypeParameter = ICON.types,
}
