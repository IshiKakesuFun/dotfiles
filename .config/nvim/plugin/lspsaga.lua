local status, saga
--------------------------------------------------------------------------------
-- https://github.com/glepnir/lspsaga.nvim
--------------------------------------------------------------------------------
-- import plugin safely
status, saga = pcall(require, "lspsaga")
if not status then
  return
end

saga.init_lsp_saga({
  border_style = "rounded",
  move_in_saga = {
    prev = "<C-k>",
    next = "<C-j>",
  },
  definition_action_keys = {
    edit = "<CR>",
  },
  -- diagnostic_header = { " ", " ", " ", "ﴞ " },
  diagnostic_header = ICON.sagaDIAGNOSTICS,
  finder_icons = ICON.sagaFINDER,
  show_outline = {
    jump_key = "o", -- default
    -- jump_key = "<cr>",
  }
})
