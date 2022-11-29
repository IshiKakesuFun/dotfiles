--------------------------------------------------------------------------------
-- https://github.com/lewis6991/gitsigns.nvim
--------------------------------------------------------------------------------
local status, gitsigns = pcall(require, "gitsigns")
if not status then
  return
end

vim.cmd("highlight link gitsignsadd title")
vim.cmd("highlight link gitsignsdelete warningmsg")
vim.cmd("highlight link gitsignschange modemsg")

gitsigns.setup({
  signs = {
    add = {
      hl = "gitsignsadd",
      text = ICON.GITSIGNS.add,
      numhl = "gitsignsaddnr",
      linehl = "gitsignsaddln",
    },
    change = {
      hl = "gitsignschange",
      text = ICON.GITSIGNS.change,
      numhl = "gitsignschangenr",
      linehl = "gitsignschangeln",
    },
    delete = {
      hl = "gitsignsdelete",
      text = ICON.GITSIGNS.delete,
      numhl = "gitsignsdeletenr",
      linehl = "gitsignsdeleteln",
    },
    topdelete = {
      hl = "gitsignsdelete",
      text = ICON.GITSIGNS.topdelete,
      numhl = "gitsignsdeletenr",
      linehl = "gitsignsdeleteln",
    },
    changedelete = {
      hl = "gitsignschange",
      text = ICON.GITSIGNS.changedelete,
      numhl = "gitsignschangenr",
      linehl = "gitsignschangeln",
    },
    untracked = {
      hl = "gitsignsadd",
      text = ICON.GITSIGNS.untracked,
      numhl = "gitsignsaddnr",
      linehl = "gitsignsaddln",
    },
  },
  signcolumn = true, -- toggle with `:gitsigns toggle_signs`
  numhl = false, -- toggle with `:gitsigns toggle_numhl`
  linehl = false, -- toggle with `:gitsigns toggle_linehl`
  word_diff = false, -- toggle with `:gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false, -- toggle with `:gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = "<author>, <author_time:%y-%m-%d> - <summary>",
  sign_priority = 6,
  update_debounce = 200, -- defualt: 100
  status_formatter = nil, -- use default
  max_file_length = 40000, -- disable if file is longer than this (in lines)
  preview_config = {
    -- options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- navigation
    map("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<ignore>"
    end, { expr = true })

    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<ignore>"
    end, { expr = true })

    local actionsOpts = { noremap = true, silent = true }
    -- actions
    map({ "n", "v" }, "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>", actionsOpts)
    map({ "n", "v" }, "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", actionsOpts)
    map("n", "<leader>ha", gs.stage_buffer, actionsOpts)
    map("n", "<leader>hR", gs.reset_buffer, actionsOpts)
    map("n", "<leader>hf", gs.refresh, actionsOpts)
    map("n", "<leader>hu", gs.undo_stage_hunk, actionsOpts)
    map("n", "<leader>hi", gs.preview_hunk_inline, actionsOpts)
    map("n", "<leader>hp", gs.preview_hunk, actionsOpts)
    map("n", "<leader>hb", function()
      gs.blame_line({ full = true })
    end, actionsOpts)
    map("n", "<leader>htb", gs.toggle_current_line_blame, actionsOpts)
    map("n", "<leader>hd", gs.diffthis, actionsOpts)
    map("n", "<leader>hD", function()
      gs.diffthis("~")
    end, actionsOpts)
    map("n", "<leader>htd", gs.toggle_deleted, actionsOpts)

    -- text object
    map({ "o", "x" }, "ih", ":<C-u>Gitsigns select_hunk<cr>")
  end,
})
