local status,
lspconfig,
protocol,
cmp_nvim_lsp,
-- typescript,
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
status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status then
  return
end
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
--{{{ format on save
--------------------------------------------------------------------------------
local format_on_save = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    local group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
    vim.api.nvim_clear_autocmds({
      group = group,
      buffer = bufnr,
    })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = group,
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
--}}}

--------------------------------------------------------------------------------
--{{{ Change the Diagnostic symbols in the sign column (gutter)
--------------------------------------------------------------------------------
local signs = ICON.cDIAGNOSTICS
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
--}}}

--------------------------------------------------------------------------------
--{{{ format diagnosti message using same icon like in gutter
--------------------------------------------------------------------------------
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

--}}}

--------------------------------------------------------------------------------
--{{{ Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
--------------------------------------------------------------------------------
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
  local c = client.server_capabilities
  -- print(vim.inspect(c))
  -- go to declaration
  if c.declarationProvider then
    map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", nOpts)
  end
  -- go to definition
  if c.definitionProvider then
    -- map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", nOpts)
    map("n", "gd", "<cmd>Lspsaga peek_definition<cr>", nOpts)
    map("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", nOpts) -- show definition, references
  end
  -- show documentation for what is under cursor
  if c.hoverProvider then
    -- map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", nOpts)
    map("n", "K", "<cmd>Lspsaga hover_doc<CR>", nOpts) -- show documentation for what is under cursor
  end
  if c.signatureHelpProvider then
    map("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", nOpts)
  end
  -- go to implemetation
  if c.implementationProvider then
    map("n", "gi", "<cmd>lua vim.lsp.buf.implemetation()<cr>", nOpts)
  end
  -- formating on demand
  if c.documentFormattingProvider then
    map("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", nOpts)
  end
  if c.codeActionProvider then
    -- map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", nOpts)
    map("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", nOpts)
  end
  if c.renameProvider then
    -- map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", nOpts)
    map("n", "<leader>rn", "<cmd>Lspsaga rename<cr>", nOpts) -- smart rename
  end
  if c.referencesProvider then
    -- map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", nOpts)
    map("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", nOpts) -- show definition, references
  end
  -- map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", nOpts)
  -- map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", nOpts)
  map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", nOpts) -- jump to previous diagnostic in buffer
  map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", nOpts) -- jump to next diagnostic in buffer
  map("n", "<Leader>o", "<cmd>LSoutlineToggle<CR>", nOpts) -- toggle outline on the right hand
  map("n", "<Leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", nOpts) -- show diagnostics for line
  map("n", "<Leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", nOpts) -- show diagnostics for cursor

  --{{{
  --[[
  if false and client.name == "tsserver" then
    -- normal
    u.set_buf_keymap(bufnr, "n", { noremap = true, silent = true }, {
      { "<Leader>rf", "<cmd>TypescriptRenameFile<CR>" }, -- rename file and update imports
      { "<Leader>oi", "<cmd>TypescriptOrganizeImports<CR>" }, -- organize imports (not in youtube nvim video)
      { "<Leader>ru", "<cmd>TypescriptRemoveUnused<CR>" }, -- remove unused variables (not in youtube nvim video)
    })
  end
  ]] --}}}
end
--}}}

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
local capabilities = cmp_nvim_lsp.default_capabilities()

--------------------------------------------------------------------------------
--{{{ Configure LSP servers
--------------------------------------------------------------------------------
-- -- configure html server
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
--   flags = lsp_flags,
-- })

-- configure css server
-- lspconfig["cssls"].setup({
-- 	 capabilities = capabilities,
--   flags = lsp_flags,
-- 	 on_attach = on_attach,
-- })

-- configure tailwindcss server
-- lspconfig["tailwindcss"].setup({
-- 	 capabilities = capabilities,
--   flags = lsp_flags,
-- 	 on_attach = on_attach,
-- })

-- configure emmet language server
-- lspconfig["emmet_ls"].setup({
-- 	 capabilities = capabilities,
--   flags = lsp_flags,
-- 	 on_attach = on_attach,
-- 	 filetypes = {
-- 		 "html",
-- 		 "typescriptreact",
-- 		 "javascriptreact",
-- 		 "css",
-- 		 "sass",
-- 		 "scss",
-- 		 "less",
-- 		 "svelte",
-- 	 },
-- })
--}}}

-- configure lua server (with special settings)
lspconfig["sumneko_lua"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  single_file_support = true,
  settings = { -- custom settings for lua
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- make the language server recognize "vim" global
        globals = { "vim" },
        disable = { "undefined-global" } -- TODO: check behavior after null-ls install
      },
      workspace = {
        -- make language server aware of runtime files
        library = {
          vim.api.nvim_get_runtime_file("", true),
          -- [VIMRUNTIME_LUA] = true,
          -- [CONFIG_LUA] = true,
        },
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  signs = true,
  underline = true,
  update_in_insert = true,
  virtual_text = {
    spacing = 2,
    prefix = "•",
    source = false,
    severity = {
      min = vim.diagnostic.severity.HINT,
    },
    format = format_virtual_text,
  },
  severity_sort = true,
  float = {
    focusable = false,
    header = { signs.Error .. " Diagnostics:", "Normal" },
    scope = "line",
    source = false,
    format = format_virtual_text,
  },
})

vim.diagnostic.config({
  virtual_text = {
    prefix = "•",
  },
  update_in_insert = true,
  float = {
    source = "always", -- Or "if_many"
  },
})
