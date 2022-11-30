--------------------------------------------------------------------------------
-- https://github.com/nvim-tree/nvim-web-devicons
--------------------------------------------------------------------------------
local status, devicons = pcall(require, "nvim-web-devicons")
if not status then
  return
end

devicons.setup({
  override = {
    zsh = {
      icon = ICON.shell,
      color = "#428850",
      cterm_color = "65",
      name = "Zsh"
    },
  },
  -- globally enable different highlight colors per icon (default to true)
  -- if set to false all icons will have the default icon's color
  color_icons = true,
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true,
})
