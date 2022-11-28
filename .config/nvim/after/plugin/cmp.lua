local status, cmp, luasnip, lspkind
--------------------------------------------------------------------------------
-- https://github.com/hrsh7th/nvim-cmp
--------------------------------------------------------------------------------
-- import plugin safely
status, cmp = pcall(require, "cmp")
if not status then
  return
end
--------------------------------------------------------------------------------
-- https://github.com/L3MON4D3/LuaSnip
--------------------------------------------------------------------------------
-- import plugin safely
status, luasnip = pcall(require, "luasnip")
if not status then
  return
end
--------------------------------------------------------------------------------
-- https://github.com/rafamadriz/friendly-snippets
--------------------------------------------------------------------------------
require("luasnip.loaders.from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect,noinsert"
vim.cmd([[ highlight! default link CmpItemKind CmpItemMenuDefault ]])

--------------------------------------------------------------------------------
-- https://github.com/onsails/lspkind.nvim
--------------------------------------------------------------------------------
-- import lspkind plugin safely
status, lspkind = pcall(require, "lspkind")
if not status then
  return
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    -- Accept currently selected item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" }, -- lsp
    { name = "luasnip" }, -- For luasnip users.
    { name = "buffer" }, -- text within current buffer
    { name = "path" }, -- file system paths
  }),
  -- configure lspkind for vs-code like icons
  formatting = {
    format = lspkind.cmp_format({
      -- with_text = false, -- DEPRECATED (use mode instead)

      -- defines how annotations are shown
      -- default: symbol
      -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
      mode = "symbol",
      symbol_map = ICON.CMP,
      maxwidth = 50,
      ellipsis_char = ICON.ellipsis, -- "…",
    }),
  },
})
