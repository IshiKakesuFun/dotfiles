local status,
lspconfig,
protocol,
cmp_nvim_lsp, -- typescript,
u
--------------------------------------------------------------------------------
-- https://github.com/neovim/nvim-lspconfig
--------------------------------------------------------------------------------
-- import plugin safely
status, lspconfig = pcall(require, "lspconfig")
if not status then
  return
end
--------------------------------------------------------------------------------
-- https://github.com/hrsh7th/cmp-nvim-lsp
--------------------------------------------------------------------------------
-- import plugin safely
-- status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
-- if not status then
--   return
-- end
--------------------------------------------------------------------------------
-- https://github.com/jose-elias-alvarez/typescript.nvim
--------------------------------------------------------------------------------
-- import plugin safely
-- status, typescript = pcall(require, "typescript")
-- if not status then
-- 	return
-- end

-- import modul safely
status, u = pcall(require, "kakesu.utils")
if not status then
  return
end

-- lsp protocol
status, protocol = pcall(require, "vim.lsp.protocol")
if not status then
  return
end

--------------------------------------------------------------------------------
-- format on save
--------------------------------------------------------------------------------
local augroup_format_on_save = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
local format_on_save = function(client, bufnr)
  if client.server_capabilities.documentFormatingProvider then
    vim.api.nvim_clear_autocmds({
      group = augroup_format_on_save,
      buffer = bufnr,
    })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup_format_on_save,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end
local enable_format_on_save = {
  "sumneko_lua",
  "denols",
  "tsserver",
}

--------------------------------------------------------------------------------
-- Change the Diagnostic symbols in the sign column (gutter)
--------------------------------------------------------------------------------
local signs = ICON.cDIAGNOSTICS
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
-- format diagnosti message using same icon like in gutter
local function format_virtual_text(diagnostic)
  local icon = signs.Info
  if diagnostic.severity == vim.diagnostic.severity.ERROR then
    icon = signs.Error
  end
  if diagnostic.severity == vim.diagnostic.severity.WARN then
    icon = signs.Warn
  end
  if diagnostic.severity == vim.diagnostic.severity.HINT then
    icon = signs.Hint
  end
  if icon == signs.Info then
    return string.format(" %s %s", icon, diagnostic.message)
  end
  return string.format(" %s [%s][%s] %s", icon, diagnostic.code, diagnostic.source, diagnostic.message)
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- formating on save
   if u.in_array(enable_format_on_save, client.name) then
    format_on_save(client, bufnr)
  end
  local map = function(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local nOpts = { noremap = true, silent = true }
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- go to declaration
  map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", nOpts)
  -- go to implemetation
  map("n", "gi", "<cmd>lua vim.lsp.buf.implemetation()<CR>", nOpts)
  -- formating on demand
  map("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", nOpts)

--   u.set_buf_keymap(bufnr, "n", { noremap = true, silent = true }, {
--     { "gf", "<cmd>Lspsaga lsp_finder<CR>" }, -- show definition, references
--     { "gd", "<cmd>Lspsaga peek_definition<CR>" }, -- see definition and make edits in window
--     { "<Leader>ca", "<cmd>Lspsaga code_action<CR>" }, -- see available code actions
--     { "<Leader>rn", "<cmd>Lspsaga rename<CR>" }, -- smart rename
--     { "<Leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>" }, -- show diagnostics for line
--     { "<Leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>" }, -- show diagnostics for cursor
--     { "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>" }, -- jump to previous diagnostic in buffer
--     { "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>" }, -- jump to next diagnostic in buffer
--     { "K", "<cmd>Lspsaga hover_doc<CR>" }, -- show documentation for what is under cursor
--     { "<Leader>o", "<cmd>LSoutlineToggle<CR>" }, -- toggle outline on the right hand
--   })
--
--   if false and client.name == "tsserver" then
--     -- normal
--     u.set_buf_keymap(bufnr, "n", { noremap = true, silent = true }, {
--       { "<Leader>rf", "<cmd>TypescriptRenameFile<CR>" }, -- rename file and update imports
--       { "<Leader>oi", "<cmd>TypescriptOrganizeImports<CR>" }, -- organize imports (not in youtube nvim video)
--       { "<Leader>ru", "<cmd>TypescriptRemoveUnused<CR>" }, -- remove unused variables (not in youtube nvim video)
--     })
--   end
end

-- protocol.CompletionItemKind = {
--   "", -- Text
--   "", -- Method
--   "", -- Function
--   "", -- Constructor
--   "", -- Field
--   "", -- Variable
--   "", -- Class
--   "ﰮ", -- Interface
--   "", -- Module
--   "", -- Property
--   "", -- Unit
--   "", -- Value
--   "", -- Enum
--   "", -- Keyword
--   "﬌", -- Snippet
--   "", -- Color
--   "", -- File
--   "", -- Reference
--   "", -- Folder
--   "", -- EnumMember
--   "", -- Constant
--   "", -- Struct
--   "", -- Event
--   "ﬦ", -- Operator
--   "", -- TypeParameter
-- }

-- used to enable autocompletion (assign to every lsp server config)
-- local capabilities = cmp_nvim_lsp.default_capabilities()


-- configure html server
-- lspconfig["html"].setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })

-- configure deno server
-- lspconfig["denols"].setup({
--   root_dir = lspconfig.util.root_pattern("deno.json"),
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })

-- configure typescript server with plugin
-- typescript.setup({
-- 	server = {
-- 		root_dir = lspconfig.util.root_pattern("package.json"),
-- 		capabilities = capabilities,
-- 		on_attach = on_attach,
-- 	},
-- })
-- lspconfig["tsserver"].setup({
--   root_dir = lspconfig.util.root_pattern("package.json"),
--   on_attach = on_attach,
--   -- filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
--   cmd = { "typescript-language-server.cmd", "--stdio" },
--   capabilities = capabilities,
-- })

-- configure css server
-- lspconfig["cssls"].setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })

-- configure tailwindcss server
-- lspconfig["tailwindcss"].setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })

-- configure emmet language server
-- lspconfig["emmet_ls"].setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- 	filetypes = {
-- 		"html",
-- 		"typescriptreact",
-- 		"javascriptreact",
-- 		"css",
-- 		"sass",
-- 		"scss",
-- 		"less",
-- 		"svelte",
-- 	},
-- })

-- configure lua server (with special settings)
-- lspconfig["sumneko_lua"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
--   settings = { -- custom settings for lua
--     Lua = {
--       diagnostics = {
--         -- make the language server recognize "vim" global
--         globals = { "vim" },
--       },
--       workspace = {
--         -- make language server aware of runtime files
--         library = {
--           [VIMRUNTIME_LUA] = true,
--           [CONFIG_LUA] = true,
--         },
--         checkThirdParty = false,
--       },
--     },
--   },
-- })

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--   signs = true,
--   underline = true,
--   update_in_insert = true,
--   virtual_text = {
--     spacing = 2,
--     prefix = "•",
--     source = false,
--     severity = {
--       min = vim.diagnostic.severity.HINT,
--     },
--     format = format_virtual_text,
--   },
--   severity_sort = true,
--   float = {
--     focusable = false,
--     header = { signs.Error .. " Diagnostics:", "Normal" },
--     scope = "line",
--     source = false,
--     format = format_virtual_text,
--   },
-- })
--
-- vim.diagnostic.config({
--   virtual_text = {
--     prefix = "•",
--   },
--   update_in_insert = true,
--   float = {
--     source = "always", -- Or "if_many"
--   },
-- })
